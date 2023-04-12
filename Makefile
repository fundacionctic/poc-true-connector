include .env.default
export $(shell sed 's/=.*//' .env.default)

ifneq (,$(wildcard ./.env.local))
	include .env.local
	export $(shell sed 's/=.*//' .env.local)
endif

clean:
	rm -fr true-connector

clone: clean
	git clone git@github.com:International-Data-Spaces-Association/true-connector.git
	cd true-connector && git reset --hard ${TRUE_CONNECTOR_COMMIT_SHA}

.PHONY: clean