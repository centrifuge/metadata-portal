.PHONY: tests

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
	export DYLD_FALLBACK_LIBRARY_PATH=$(shell xcode-select --print-path)/Toolchains/XcodeDefault.xctoolchain/usr/lib
endif

all: tests verifier updater collector cleaner signer

verifier:
	cargo run --release --locked verify

updater:
	cargo run --release --locked update

collector:
	cargo run --release --locked collect

cleaner:
	cargo run --release --locked clean

signer:
	cargo run --release --locked sign

tests:
	cargo test --release

docker.%:
	docker-compose run --rm $(*)
