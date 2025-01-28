# Brain Criticality Documentation

The folder `brain-criticality` contains functions that analyze criticality in avalanches, provided an instance of the `regions` class.

## Loading Data

First, you need to load the data into a `regions` object:

```matlab
session = '/mnt/hubel-data-131/perceval/Rat003_20231213/Rat003_20231213.xml';
R = regions(session, states=["other"; "sws"; "rem"]);
R = R.loadSpikes();
```

Change the `session` path to the one you are interested in. Some parameters can be passed to the `regions` constructor to filter states and phases within the recording. See the `regions` documentation, also known as `Pietro`.

## Computing Avalanches

```matlab
R = R.computeAvalanches();
```

If you want to compute the avalanches on the principal component reduction, you can pass the following arguments:  
- **`dopc`**: If set to `true`, PCA will be performed on the spike matrix.  
- **`var`/`pc`**: The total explained variance you want to keep or the number of principal components you want to retain.  
- **`first`**: If set to `true`, the analysis will keep the first `pc` components. Otherwise, it will keep the last `n-pc` components, where `n` is the total number of components.  
- **`pcPercentile`**: Percentile of the spiking profile below which the profile is set to `0`.

For example:

```matlab
R = R.computeAvalanches(dopc=true, var=0.1);
```

## Plot Analysis

You can obtain the most relevant information about the criticality of avalanches with the function `plotRawRegionAnalysis`. This function outputs the estimated power law of the `size` and `lifetime` of avalanches, the relationship between the `area` and the `lifetime`, as well as the `shape collapse` and the slow decay of autocorrelation.

```matlab
plotRawRegionAnalysis(R);
``` 