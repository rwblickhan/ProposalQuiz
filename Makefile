default: brew mint git

.PHONY: brew mint git

brew:
	brew install mint

mint:
	mint bootstrap

git:
	cp Scripts/post-commit .git/hooks/post-commit

open: default
	open Spreppy.xcodeproj
