Mimir
---------

Mimir is designed as a 'Machine-Learning agent' : it is a self-sufficient program that runs on a dedicated host, preferably a GPU machine or a Spark cluster master. 
Mimir takes as input two kinds of Machine Learning calls : learning call (trying to fit a ML model on provided training data), or prediction call (proposing a prediction based on provided input and selected model).
Mimir can run in two modes : first, as a running agent that listens to json-formatted calls, coming from a Kafka server or an HTTP request, second, as a script executed once on a single command.
Mimir is written in python 3, designed as a python package that can be installed through pip, and can run on any debian-like Linux host, after installing the required packages.