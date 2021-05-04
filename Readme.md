##  URL Shortening Application
A Simple dockerized URL Shortening Application

Possibilities
1. User can enter a long url and get the shorten URL

## System requirements

- Docker
- Composer https://getcomposer.org/
- Makefile support 


- backend service written using symfony 5.2
- frontend written using nextjs

## Project setup
1. Setup both backend and front-end via `make setup` and follow the instruction in the cli

Application is ready be accessed via http://localhost:3000

### Additional commands
- Run the tests
```bash
make tests
```

- Stop the application containers
```bash
make stop
```

- Restart the application containers
```bash
make restart
```

- Destroy the application containers
```bash
make destroy
```

## a/b test
30/70 between external API (https://dev.bitly.com/) and my own implementation

percentage can by changed via following configuration

```yaml
    Travaux\VariantRetriever\Retriever\VariantRetrieverInterface:
        class: Travaux\VariantRetriever\Retriever\VariantRetriever
        calls:
            - addExperiment:
                  - !service
                      class: Travaux\VariantRetriever\ValueObject\Experiment
                      arguments:
                          - 'shortening-url-experiment'
                          - !service
                              class: Travaux\VariantRetriever\ValueObject\Variant
                              arguments: [ 'control', 30 ]
                          - !service
                              class: Travaux\VariantRetriever\ValueObject\Variant
                              arguments: [ 'variant', 70 ]
``` 


## Extra

Looking forward to hearing your valuable feedback.

Thank you.

