# Dataform example project

This repo is to explore features of Dataform on below points:

- unit tests
- assertions
- code reuse
- managing table dependencies
- documentations

## Examples

- [Create a dataset, table and view](./docs/create-dataset-table-view.md)
- [Unit test a view](./docs/create-dataset-table-view.md#step-5-unit-test-the-view)

## How to run the project

#### Step 1: Install dependencies

```
cd dataform
dataform install
```

#### Step 2: Compile & format

In `dataform/` directory, run:

```
dataform format
dataform compile
```

#### Step 3: Store credentials to run tests and deploy

In `dataform/` directory, run:

```
dataform init-creds bigquery .
```

#### Step 3: Run unit tests

In `dataform/` directory, run:

```
dataform test
```

#### Step 4: Deploy

In `dataform/` directory, run:

```
dataform run
```

## Appendix

### How to run Dataform CLI locally (Docker)

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
