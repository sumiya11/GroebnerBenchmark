# Gröbner basis benchmarks

This repository powers [GrobnerBenchmark](https://sumiya11.github.io/GrobnerBenchmark).

## To build website locally

#### 0.  Creating new environment

```
python -m venv venv
source venv/bin/activate
```

#### 1. Installation

Install required dependencies:

```python
python -m pip install -r requirements.txt
```

#### 2. Building

To build the website, run this command in your favorite terminal:

```
python build.py
```

Resulting HTML files will be in `build/`.
