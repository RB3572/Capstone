<div align="center">
	<img alt="Lines of code" src="https://img.shields.io/tokei/lines/github/RB3572/Capstone">
	<img alt="GitHub" src="https://img.shields.io/github/license/RB3572/Capstone">
	<img alt="GitHub repo file count" src="https://img.shields.io/github/directory-file-count/RB3572/Capstone">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/RB3572/Capstone">
	<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/RB3572/Capstone">
	<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/RB3572/Capstone">
</div>

# <p align="center">[Insert Project Topic Name]</p>
<p align="center">Rakshit Kaushik, Alessandro Ferrari, Sergio Papa Estefano, Rishi Bhargava</p>

## Data
Past stock data will be obtained using the quantmod package. Quantmod stands for quantitative financial modeling framework, and it is used to "specify, build, trade, and analyse quantitative financial trading strategies."[(cran.r-project.org)](https://cran.r-project.org/web/packages/quantmod/quantmod.pdf) Opening, high, low, closing, and the adjusted closing prices of a stock can be obtained using the ``` getSymbols() ``` function. It contains data from January 3, 2007 to the day before the current date. 

<p align="center", width="30px"><img src="https://i.ibb.co/ZKj42Mn/022b8d8e-e92d-483b-b2db-4f04446054a9.png" alt="022b8d8e-e92d-483b-b2db-4f04446054a9" border="0"></a>

### Importance of data: 
- Stock Market Data(opening prices, closing prices, high/low prices) => technology: train an AI model using historical data to predict stock prices => if successful, we can deploy this application as a private option for our group to use when investing => less helpful (comparing with the next example)
- Stock Market Data(opening prices, closing prices, high/low prices) => technology: train an AI model using historical data to predict stock prices => if successful, we can deploy this application as an open source package for individuals to use when investing => more helpful (community impact)
## Benchmark 
Existing projects include:
- [MCMC Simulation/MCTS](https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/scripts/R/2021Summer/day_3.R)
	- MCMC randomly calculates paths that stock price could follow
	- MCTS uses past data to tune the parameters used in the MCMC simulation
		- parameters: mean, standard deviation
	- Once the parameters create simulated data that is similar to past data, they can be used to make predictions
- [Sentiment Analysis of Newspapers](https://github.com/dineshdaultani/StockPredictions)
	- Uses past stock data and newspaper articles
	- Sentiment of articles analysized using Natural Language Toolkit package (NLTK)
	- Stock prices and sentiment used as explanatory variables for neural network, stock prediction is the response variable
- [Brownian Motion](https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/scripts/R/2021Summer/day_4.R)
	- Uses the knowledge that plots of simulated particle movement match plots of stock returns (gif credit: [yiqiao-yin](https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/docs/big-data-machine-learning/notes/Day3.md))
	- Parameters for brownian motion can be tuned using past data to predict future stock trends

<div>
  <img src="https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/pics/brownian-motion.gif" width="480px" /><img src="https://github.com/yiqiao-yin/Introduction-to-Machine-Learning-Big-Data-and-Application/blob/main/pics/cross-section-stock-returns.gif" width="480px" />
</div>


## Proposed Model/Algorithm

(Create a diagram to demonstrate how the project code works)
