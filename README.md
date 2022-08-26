# Dataform example with 

This repo is to explore features of Dataform on below points:
- unit tests
- assertions
- code reuse
- managing table dependencies
- documentations

## Tasks

- [x] Add Dockerfile to run Dataform CLI
- [x] Add devcontainer.json for VSCode
- [ ] Add unit tests

## How to run assertions locally

Below make target runs dataform assertions in a container:
```
make dataform/test
```

Alternatively, run `dataform` directly in a container:
```
# entre the container
make docker/run

# in /workspaces/dataform directory in the container
dataform run
```

## Appendix

###  How to run Dataform CLI locally (Docker)

```
make docker/build

# To enter a container with dataform CLI
make docker/run

# Run dataform --version in the container
# The current directry is mounted as /workspaces
```

### How to run Dataform CLI locally (VSCode)

1. Open the project in Container
2. Open Terminal to entre the container
3. Run `dataform --version`

### How this Dataform project was created

The base Dataform project was copied from https://github.com/hekuwatada/dataform-assertions-example.

### References
- https://docs.dataform.co/guides/assertions