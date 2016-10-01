# Tempora
## A way to monitor Twitter for mentions of your referral campaign's coupon code

# Running It
```bash
bundle install
```
## Generating Authentication
```bash
bundle exec figaro install
```
Input the relevant information into `config/application.yml`.
Generate it at *[apps.twitter.com/](https://apps.twitter.com/) > Keys and Access Tokens*.
You will need to click on the *Generate access tokens* button to get the last two values.
## Starting Server
```bash
rails server
```
