# main.py

import os
import yaml
import pandas as pd
from src.data.load_data import load_data
from src.data.preprocessing import preprocess
from src.features.build_features import create_features
from src.models.train_model import train_model
from src.models.predict_model import save_model

