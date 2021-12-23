# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v0.1.0 (2021-11-24)

* BREAKING: Instead of setting `api_key` in config, we pass it as first arg,
  so `List.all()` becomes `List.all("your_api_key")`. This change was neccessary
  to work with multiple api keys in the same application.
  

## v0.0.6 (2020-10-20)

* Enhancements
  * `add_member` is now an upsert (Thanks Joakim Nylén)
  * `destroy_member` for deleting a member permanently (Thanks Joakim Nylén)
  * Fix Elixir 1.11 warning about Jason
  * Update deps


## v0.0.5 (2020-09-01)

* Enhancements
  * Add `other_fields` param to `List.add_member`. Useful for adding gdpr field


## v0.0.4 (2020-07-23)

* Enhancements
  * Switch to Jason for JSON
  * Update deps

## v0.0.3 (2019-05-03)

* Enhancements
  * Fix Elixir warnings
  * Relax deps

## v0.0.2 (2016-04-30)

* Enhancements
  * Relax poison dep

## v0.0.1 (2015-12-20)

* Initial release.
