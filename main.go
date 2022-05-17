package main

import (
	"fmt"
	"os"
	"os/exec"
	"syscall"
)

func main() {
	coredns := exec.Command(
		"/usr/local/bin/coredns",
		os.Args[1:]...,
	)

	coredns.Env = append(coredns.Env, os.Environ()...)
	coredns.Stdin = os.Stdin
	coredns.Stdout = os.Stdout
	coredns.Stderr = os.Stderr
	err := coredns.Run()
	if err != nil {
		fmt.Fprintln(os.Stderr, err.Error())
		if exiterr, ok := err.(*exec.ExitError); ok {
			if status, ok := exiterr.Sys().(syscall.WaitStatus); ok {
				os.Exit(status.ExitStatus())
			}
		} else {
			fmt.Fprintf(os.Stderr, "%v: %v\n", coredns.Args, err)
		}
	}
}
