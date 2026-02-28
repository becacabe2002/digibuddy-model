# digibuddy-model
Regression Model for DigiBuddy

## Project overview

This repository contains regression and classification models used in the DigiBuddy project, along with Jupyter notebooks for experimentation and model comparison.

### Notebooks

- `compare_models.ipynb` – compare different model types and configurations.
- `SHAP-RandomForest.ipynb` – analyze feature importance and model behavior using SHAP values for a Random Forest model.

You can open these notebooks with Jupyter Lab, Jupyter Notebook, or VS Code to explore the data, training process, and model evaluation.

## Development environment setup

Use the provided `setup.sh` script to create and configure a local Python virtual environment:

```bash
chmod +x setup.sh        # make sure the script is executable (first time only)
./setup.sh               # create .venv and install dependencies from requirements.txt
```

The script will:
- Check that `python3` is available
- Create a `.venv` virtual environment (if it does not already exist)
- Upgrade `pip`
- Install all dependencies from `requirements.txt`

After running the script, activate the virtual environment with:

```bash
source .venv/bin/activate
```

Then you can start working with the notebooks.