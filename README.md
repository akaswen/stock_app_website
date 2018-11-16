# Portfolio Backtester

The Portfolio Backtester takes your stocks and their percentages and initial capital and uses this information to calculate earnings. It therefore allows you to create a portfolio and use historical share price data to see how well it would have done.

Please note that this website is designed for educational purposes only. It is not intended to be investment advice. Seek a duly licensed professional for investment advice.

This Website can be found live [here](https://damp-mesa-18718.herokuapp.com/)

## Use Instructions

### Instructions for creating a portfolio

* First, if you haven't done so, Sign up or Sign in
* Navigate to the New Portfolio page
* Enter in a name for your portfolio and the amount you would like to invest
* Below that you can enter in the symbols (e.g., aapl or msft) and the portfolio percentage for each stock you want to put into the portfolio.
* The portfolio percentage determines how much of the initial capital to invest in each stock and is presented in decimal form. E.g., if you have an initial capital of $50000 and you want to invest half of that in aapl, you would enter 0.5 for portfolio percentage.
* Be sure that the total percentage numbers for all of the stocks add up to 1
* Each portfolio can include up to ten different stocks. If you'd like to have less, simply leave the other entries blank
* There are still a few limitations for the API, so if you enter in a stock that you know is correct but you receive an error, it may be that IEX (the api providing the data) does not have those records yet.

### How it works


* The symbols are used to get the stock history from IEX API.
* Since there can be a lot of information being pulled for each stock, please allow up to a couple minutes after submitting the form for the calculations to be made.
* Up to five years of data are pulled for each stock
* Once Portfolio Backtester has all the data (opening prices, adjusted markets, highs, lows, etc), it collects all of the closing prices from each day
* Not every stock has a full five years of data. If that is the case, Portfolio Backtester will cut down each stock into the same time length. E.g., if one stock has 5 years of data and another has only one year, both stocks are cut down to one year.
* After pulling out the closing values and possibly trimming the length of each stock to make them the same, it will start on the earliest day, use the initial capital you have submitted to "buy shares", then check the price one year later and "sell". It will then do this starting on the next day and so on for all the data available.
* Once the results of each buy/sell period are calculated, the lowest result, the highest result, and the average result are returned. This is done for a one year investment period, two year investment period, and three year investment period.

### Results


* Each portfolio links to its results page
* The results display the initial capital and each stock with the percentage alotment
* Beneath those are the results of the portfolio. It will show the best, worst, and average results over the period of one, two, and three years of investing. If sections have no amount listed, it means there were not enough records to calculate those results.


## Installation Instructions

Make sure you have at least version 2.5.0 of Ruby and 5.2 of Rails

* clone this repository
* install all the gems with `$ bundle install`
* setup the database with `$ rails db:setup`
* run all the migrations with `$ rails db:migrate`
* make sure all the tests pass with `$ rspec`
* start the server with `$ rails server`
