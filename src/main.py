"""
cpu-ml-demo main module

This module serves as the entry point for the cpu-ml-demo application.
"""

import numpy as np
import pandas as pd
from icecream import ic
from sklearn.linear_model import LinearRegression


def main():
    """
    Entry point for the cpu-ml-demo application.

    Prints a greeting message to the console.
    """
    message = "Hello from cpu-ml-demo!"
    ic(message)
    print(message)

    # Numpy: create and log a simple array
    arr = np.array([1, 2, 3, 4, 5])
    ic(arr)

    # Pandas: create and log a simple DataFrame
    df = pd.DataFrame({"x": [1, 2, 3], "y": [2, 4, 6]})
    ic(df)

    # Scikit-learn: fit a simple linear regression
    x_features = df[["x"]]
    y = df["y"]
    model = LinearRegression()
    model.fit(x_features, y)
    ic(model.coef_, model.intercept_)


if __name__ == "__main__":
    main()
