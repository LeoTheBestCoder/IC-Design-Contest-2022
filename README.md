# IC Contest 2022
## Group: E
Cell Based IC Design Category for Undergraduate Level

## Topic
Job Assignment Machine

## Description
The JAM problem is to calculate costs for each possible
combination and identify the one that delivers the lowest.

In this problem, the information about the job
cost for workers is given. We want to find the **lowest cost** among all the possible combinations, and **the number of combinations** that contains the lowest cost.

An example for N = 5 with sequence of [3, 2, 4, 0, 1]:
<table border=2 class="dataframe">
    <tbody>
        <tr>
            <th></th>
            <th>Job1</th>
            <th>Job2</th>
            <th>Job3</th>
            <th>Job4</th>
            <th>Job5</th>
        </tr>
        <tr>
            <th>Worker A</th>
            <th>12</th>
            <th>22</th>
            <th>34</th>
            <th><u>54</u></th>
            <th>12</th>
        </tr>
        <tr>
            <th>Worker B</th>
            <th>45</th>
            <th>21</th>
            <th><u>97</u></th>
            <th>98</th>
            <th>34</th>
        </tr>
        <tr>
            <th>Worker C</th>
            <th>54</th>
            <th>88</th>
            <th>21</th>
            <th>22</th>
            <th><u>34</u></th>
        </tr>
        <tr>
            <th>Worker D</th>
            <th><u>12</u></th>
            <th>43</th>
            <th>57</th>
            <th>21</th>
            <th>33</th>
        </tr>
        <tr>
            <th>Worker E</th>
            <th>35</th>
            <th><u>98</u></th>
            <th>32</th>
            <th>1</th>
            <th>13</th>
        </tr>
    </tbody>
</table>

The total job cost can be calculated as 54+97+34+12+98.

## Result
<table border=2 class="dataframe">
    <thead>
        <tr>
            <th>Level</th>
            <th>Cycle Count</th>
            <th>Synthesis Area</th>
            <th>HDL simulator</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th>A</th>
            <th>403206</th>
            <th>9722</th>
            <th>ncverilog</th>
        </tr>
    </tbody>
</table>

Level A: `Gate-level` and `RTL simulations` are **completely correct** given the clock period of **10ns**, with total simulation cycle smaller than 600000 cycles and area smaller than 10000 um^2 after synthesis.