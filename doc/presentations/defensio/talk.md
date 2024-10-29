### 1 
Good morning everyone and thank you for joining me today.
Today I want to present the results I obtained from a 6 month intership at the Austrian Institute of Technology.
The picture you see here on the first slide is already a glimpse into part of my results. 
What we see here are multiple ZrO2 layers on top of steel substrate. 
The colors we wahrnehmen are created by the precursor solution drying up irregularly. 
But let's not get ahead of us. 

### 2 
My presentation today is structured into 4 grob parts.
###### Motivation
I want to talk about the motivation why we want to apply a passivation layer on top of the steel substrate. 
The ultimate goal is to use the passivated steel as substrate CIGS PV cells. 
###### Methods
Then I will introduce you to the methods I used during the work.
That is the recipe used to create the precursor solutions and how the actual layers were created
###### Calculations
In the next section I want to introduce PSO and and how we processed the measurements to arrive at two *quantitative numbers* which could be used in the PSO. 
###### Results
Finally I will present you the results obtained from *the tedious task of sample preparation* and what insight the optimisation offered. 

### 3 CIGS
CuFeS2 is the OG chalcopyrite. 
On the right we see a classic Copper Indium Gallium Selenide Cell. 
Going through the layers from top to bottom:
- (aluminium doped) zinc oxide is used as a transparent contact 
- Cadmiun Sulfide is used as n-type buffer 
- CIGS is p-type absorber layer
- molybdenum is used both as back contact, which also reflects non absorbed light back

On the left we see a very nice property of CIGS.
Namely, when we look at the band gap of Copper indium selenide and copper gallium selenide, we notice a huge difference. 
Conveniently both *combinations* have the same structure, the chalcopyrite structure CuFeS2. 
That means that the indium and gallium can be used in place of each other and that the band gap can be tuned by tuning the indium gallium ratio in CIGS. 

It is also noticable that CIGS belong to a group of PV called thin sheet PV. 
Other examples include *xxx,yyy,zzz*
They exhibit an absorption coefficient up to 100 times higher in the *entsprechend* range of wavelenghts and can thus be made orders of magnitude thiner. 
This make flexible PV cells possible. 
This is of course only possible if the substrate on which the cells *are located* are also flexible. 

### 4 CIGS modules
One single PV cell mostly does not provide enough voltage. 
Thus multiple cells are connected in series to make a module -
like a voltaic pile to create a battery.
The contacts (shown in black) in general touch the substrate.
So the substrate needs to be insulating. 
The two most often used substrates are glass and polymers. 
Both come with their own caveats: 
Glass is insulating, but very brittle. 
Polymers are mostly insulating but not very heat resistant. 
Stell is heat resistant, ductile, but also conducting.
In order to use it as substrate it needs to be treated before. 
For example with an ZrO2 layer. 

### 5 Recipe 

The first recipe was taken from a paper which described ZrO2 layers, but the results were rather modest.
So, I want on a search for a better recipe. 
This was the paper which I used as blueprint for the recipes used in this work. 
Although the recipe was aimed at aluminium oxide and not all reagents were available in the lab, the first tests yielded , fully coated and homogeneous layers. 

The layers were very thin, so we tried to increase the concentration of zirconium in the precursor solution. 
The increased concentration shortened the time the solution was stable, though. 

Let me shortly walk you through the ingredients: 
- bothanol is the solvent
- zirconium *(iso)propoxide* acted as precusor
- acetylacetate was used as chelating agent to stabilize Zr in the solution and prevent percipitation
- AcOH was originally described as further stabilisation agent. By accident we discovered that when isopropanol, which was widely used for desinfecting hands during covid and to clean glassware, the stable time of the solution increased noticeable without worsening the passivation properties of the layers. 

### 6 Tape Casting 
One requirement was to use tape casting as route of creation for the ZrO2 layers.
Tape casting has the advantage that it can easily be upscaled to an industrial *prdoction* by means of roll to roll process.
What you see here is the Erichsen Coatmaster 510 film applicator with a heatable plate.
The brown circles are 2.5 mm patches of porous metal where a vacuum could be applied to hold samples in place.
In order to increase the suction at locations of interest, the other circles were covered with tape. 

Once, the desired temperature was reached, the blade and the sample were put into position, the solution applied to the sample and the blade moved over the sample. 
Moving the blade over the sample with a constant speed and an set temperature *avoids* drying staines observed on the sample on the first slide.
After each layer, the sample was dried on a 200 degree heating plate. 
After the desired number of layers were applied, the sample was put into a furnace, heated at a specified rate to calcination temperature (300,400,500) and baked for 1 hour. 

### 7 Sputtering 
On the right hand side we can see a steel substrate with 6x3F layers applied.
On the left hand side we see a shadow mask for sputtering aluminium contacts onto the sample. 

###### 7 Sputtering 2
Here we see sample with sputtered contacts. 
On each the left and right edge we see a silver spot.
Here the layers were removed by means of sandpaper and then a silver was applied by means of paste to create a contact to the steel. 
This allows us to measure the leakage current of the layer at each contact with an Agilent 4156C Precision Semiconductor Parameter Analyzer. 
Current-voltage curves were measured from -0.5V to 0.5 volt with steps of 10 mV. 

### 8 PHD and Leakage Current 
Two metrics were calculated from measurements of one sample.

- Conductivity: is the inverse of the resistance. 
For each contact we measured a current-voltage curve. 
Taking the derivative at zero voltage gives the conductivity i.e. the inverse resistance. 
This number should be close to 0  in the best case.

- Pin Hole Density: that is the number/ratio of contact were the current conductivity is above a certain threshold.
The measured conductivity ranged from close to 1 to 10 to the power of -12.
The arbitrary threshold was chosen to be 10 to the power of -5.
If the conductivity was large than this threshold, it is defined as a pin hole.
We then count the number of pin holes and devide by the number of measured contacts per sample.
This gives us the mertic called pin hole density abreviated with a greek rho, which often is used for densities, although the metric is a ratio and no density per se. 
The pin hole density can be 0 for a sample where are conductivities are 10 to the power of minus 6 and 10 to the power of minus 12. 
Thus a more quantitative metric for the electrical insulation abilities was contrieved. 

- The leakage current: We again take the logarithm to take into account the large range of calculated conductivities. 
Taking the negative results in a positive number, which is 12 for an excellently insulating measurement and 1 for a poorly insulating measurment. 
This metric was design in the style of a MSE.
The number should be big for "bad" inputs and small for "good" inputs. 
The number was then squared to make the metric more sensitive to "bad" inputs. 
Finally the number was devided by the number of inputs as this could differ from sample to sample.

### 9 PSO
- belongs to a larger class of population based optimisations

    - genetic algorithm: where we have a population and each indivual has a genome which encodes different input variables.The fittest individuals mix their genomes and there might be some mutation and the offspring then is added to the population and the least fit die. 

    - PSO is inspired by flocks of birds or school of fish.
Each individual is called a particle. 
The particles are moving in a multi-dimensional space, where each dimension is an input variable.
Each particle is initialized with a random velocity, that is a direction and speed.
The position for the next time step is determined by the position and the velolicty, which is composed of the previous velocity, the direction of the best position and a stochatic share to avoid local minima.

- emma: the R package `emma` implements a PSO.
It uses Multivariate Adaptive Regression Splines to model the fitness function.

### 10 PSO input variables 
These were the final variables and discrete levels used as inputs, which span the multidimensional space. 
- concentration of precursor solution
- number of layers 
- coating temperature
- coatnig speed
- calcination temperature
- heating rate for calcination 

### 11 SEM 
Here we can see scanning electron microscope images of the samples. 
- A and C show ZrO2 on top of fluride dope tin oxide, which was used for first experiments. 
In left top image the crystalls are flouride doped tin oxide (FTO) and the darker area are ZrO2.
We can see that the ZrO2 is patchy and does not cover the surface. 
This sample was produced with the initial "bad" recipe. 

- figure C shows the cross section of 5 layers of ZrO2 on top (or here below) FTO

- figures B and D show layers on top of steel. In figure B we see an irregularity in the bottom left corner and small slits. These are not deep as can be seen from figure C

- figure D shows a side view of *some* layer on top of stell. In contrast to FTO, steel is very ductile and not easily breakable.
Thus the surface was scratched to inspect the thickness of the layers. 

### 12 I-V characteristics
What wer see here current-voltage curved optained from a single contact. 
- figure g shows a very insulating measurement.
- figure h and i show moderately insulating measurements

### 13 I-V characteristics 
Here, each figure represents a sample.
Note, that the current axis is logarithmic to accomodate the range of measurements on a single sample. 

- The most left hand figure shows measurments from a very well insulating sample. 
Even the outliers are below the pin hole threshold. 

- the middle figure shows a sample with very low condutivity measurments and also with high conductivity measurements above the pin hole threshold

- the right hand figure c shows a badly insulating sample

### I-V characteristics 
These figures show the same samples as in the previous slide. 
But instead of showing the I-V curves, we now plotted the number of measurements with the conductivity in a certain range. 
This again visualizes the overall insulating property of a sample nicely. 
The vertical line indicates the threshold. 
- the left shows a nicely insulating sample
- the middel figure shows insulating sample with some pinholes
- the right figure shows a badly insulated sample

### 15 Pin Hole Density 
We can now scatter plot input variables against the calculated pin hole density. 
- Top left we see that the higher the concentration of the precursor solution the lower is the ratio of pin holes. 
- Interestingly the number of layers does not have the same influence
- Also, bottom left, I find it interesting that lower calcination temperatures lead to less pinholes. This might be attributed to non-final calcination

### 16 Leakage current
We can see the same trends for the leakage current metric, but less pronounced. 
The effect on the input variables is less noticable because non-insulating measurements are punished stronger in this metric. 
- at the top left we see higher concentrations lead to better insulation 
- The Top right figure shows that number of applied layers does have an effect on the insulation properties of samples. 
- The Bottom left figure shows the same trend for calcination temperature as pin hole ratio. 

### 17 PSO generations 
On this slide the generation number is plotted against the metrics 

### 17 PSO generations 
On this slide the generation number is plotted against the metrics. 
At the beginning 10 samples were randomly generated and the best 5 were chosen to propagate. 
Each line represents individual "particles". 
We see for both leakage currant and pin hole ratio that the initial samples had very low metrics, 
then moved up (which can be interpreted as moving in the wrong direction),
but then learned to move into a direction which represents process variables which yield more insulating ZrO2 layers. 

### 18 Comparison 
### Summary 

