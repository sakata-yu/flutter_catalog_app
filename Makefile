# Makefile

.PHONY: init format analyze build clean env create-feature

init: build env

format:
	bash scripts/format.sh

analyze:
	bash scripts/analyze.sh

build:
	bash scripts/build_runner.sh

clean:
	bash scripts/clean.sh

env:
	bash scripts/prepare_env.sh

create-feature:
	@bash scripts/create_feature.sh $(cid) $(name)
