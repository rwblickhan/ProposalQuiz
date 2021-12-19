default: brew mint

.PHONY: brew mint

brew:
	brew install mint

mint:
	mint bootstrap

open: default
	open Spreppy.xcodeproj
