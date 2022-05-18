all: _gokrazy/extrafiles_arm64.tar _gokrazy/extrafiles_amd64.tar

_gokrazy/extrafiles_amd64.tar:
	GOARCH=amd64 make -C external/coredns
	mkdir -p _gokrazy/extrafiles_amd64/usr/local/bin
	cp external/coredns/LICENSE _gokrazy/extrafiles_amd64/usr/local/bin/LICENSE.coredns
	cp external/coredns/coredns _gokrazy/extrafiles_amd64/usr/local/bin/
	cd _gokrazy/extrafiles_amd64 && tar cf ../extrafiles_amd64.tar *
	rm -rf _gokrazy/extrafiles_amd64

_gokrazy/extrafiles_arm64.tar:
	GOARCH=arm64 make -C external/coredns
	mkdir -p _gokrazy/extrafiles_arm64/usr/local/bin
	cp external/coredns/LICENSE _gokrazy/extrafiles_arm64/usr/local/bin/LICENSE.coredns
	cp external/coredns/coredns _gokrazy/extrafiles_arm64/usr/local/bin/
	cd _gokrazy/extrafiles_arm64 && tar cf ../extrafiles_arm64.tar *
	rm -rf _gokrazy/extrafiles_arm64

clean:
	rm -f _gokrazy/extrafiles_*.tar
