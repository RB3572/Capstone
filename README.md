<div align="center">
	<img alt="GitHub Workflow Status" src="https://img.shields.io/github/workflow/status/RB3572/Capstone/lint-project">
	<img alt="Lines of code" src="https://img.shields.io/tokei/lines/github/RB3572/Capstone">
	<img alt="GitHub" src="https://img.shields.io/github/license/RB3572/Capstone">
	<img alt="GitHub repo file count" src="https://img.shields.io/github/directory-file-count/RB3572/Capstone">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/RB3572/Capstone">
	<img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/RB3572/Capstone">
	<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/RB3572/Capstone">
	<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/RB3572/Capstone">
</div>

# <p align="center">Machine Learning Stock Predictions</p>
<p align="center">Rakshit Kaushik, Alessandro Ferrari, Sergio Papa Estefano, Rishi Bhargava</p>

## Data
Past stock data will be obtained using the quantmod package. Quantmod stands for quantitative financial modeling framework, and it is used to "specify, build, trade, and analyse quantitative financial trading strategies."[(cran.r-project.org)](https://cran.r-project.org/web/packages/quantmod/quantmod.pdf) Opening, high, low, closing, and the adjusted closing prices of a stock can be obtained using the ``` getSymbols() ``` function. It provides data for every day from January 3, 2007 to the current date. 

<p align="center", width="30px"><img src="https://i.ibb.co/DfHkKGf/ef221867-8547-4e7b-8a9c-8455011de2bb.png" alt="ef221867-8547-4e7b-8a9c-8455011de2bb" border="0"></a>

### Importance of data: 
- Stock Market Data(opening prices, closing prices, high/low prices) => technology: train an AI model using historical data to predict stock prices => if successful, we can deploy this application as a private option for our group to use when investing => less helpful (comparing with the next example)
- Stock Market Data(opening prices, closing prices, high/low prices) => technology: train an AI model using historical data to predict stock prices => if successful, we can deploy this application as an open source package for individuals to use when investing => more helpful (community impact)
## Benchmark 
Existing projects include:
- [MCMC Simulation/MCTS](https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/scripts/R/2021Summer/day_3.R)
	- MCMC randomly calculates paths that stock price could follow
	- MCTS uses past data to tune the parameters used in the MCMC simulation
		- parameters: mean, standard deviation
	- Simulated data will accurately describe historical data => can be used to make predictions
- [Sentiment Analysis of Newspapers](https://github.com/dineshdaultani/StockPredictions)
	- Uses past stock data and newspaper articles
	- Sentiment of articles analyzed using Natural Language Toolkit package (NLTK)
	- Stock prices and sentiment used as explanatory variables for neural network, stock prediction is the response variable
- [Brownian Motion](https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/scripts/R/2021Summer/day_4.R)
	- Uses the knowledge that plots of simulated particle movement match plots of stock returns (gif credit: [yiqiao-yin](https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/docs/big-data-machine-learning/notes/Day3.md))
	- Parameters for brownian motion can be tuned using past data to predict future stock trends

<div>
  <p align="center"><img src="https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/pics/brownian-motion.gif" width="400px" /><img src="https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/pics/cross-section-stock-returns.gif" width="400px" />
</div>


## Proposed Model/Algorithm: 
1) Linear Regression: y=⍺+βx+ε | x = time, y = stock price, ⍺ = y intercept, ε = error. Linear regression is used to find the relationship between two variables, or in our case, time and stock price. While linear regression can reveal a trend in stock data, it's not optimal for predicting stocks, as any sudden change in price can cause a user to lose money.
 <p align="center"><a href="https://ibb.co/zQG24zb"><img src="https://i.ibb.co/XjS5Cqp/91cf0ec1-0a0e-4c28-9dff-ad554150d080.png" alt="91cf0ec1-0a0e-4c28-9dff-ad554150d080" border="0"></a>

2) Recurrent Neural Network using stock returns: RNNs are designed for sequence prediction problems, making them ideal for predicting stock data. The neural network will use stock returns as both the explanatory and response variables. Another option for data would be to use the closing price. A recurrent neural network could learn from past stock prices and attempt to predict the future. But, stock price trends vary from year to year, so training an AI to predict next year's stock closing prices using last year's closing price data is un-ideal. Stock returns don't have as much variation and are better suited for making predictions with an RNN. 

<p aligns="center"><img src="https://raw.githubusercontent.com/RB3572/Capstone/main/assets/second-model-plot.png" alt="Neural Network Model"></p>
	
3) Recurrent Neural Network using golden crosses: Instead of stock returns, our explanatory variable is price data leading up to a golden crosses, and the response variable is price data after the golden cross. A golden cross occurs when the plotted line of a stock's long term average crosses the line of its short term average. If the short term average starts below the long term average and crosses above it, the pattern is called a golden cross. Otherwise, it's called a death cross. A golden cross is a signifier of a bull market. Our model attempts to predict the stock price outcome after a golden cross. 
 [<p align="center"><img src="https://i.ibb.co/rGDzzCW/Screen-Shot-2021-07-05-at-2-06-25-PM.png" alt="Screen-Shot-2021-07-05-at-2-06-25-PM" border="0"></a>](https://www.tradingview.com/chart/LOExVaqb/)
