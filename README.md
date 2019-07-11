# draw_network

Code to draw (brain) networks from three angles, as "ball-and-stick" diagrams

There are four versions of this function:

<pre>
<b>draw_network</b>               colored nodes + simple black lines as edges
<b>draw_network_sig</b>           as above, with option to make certain (eg: "non-significant") nodes transparent
<b>draw_network_edgecol</b>       colored nodes + colored edges
<b>draw_network_edgecol_sig</b>   as above, with option to make certain (eg: "non-significant") nodes transparent
</pre>

(These are all special cases of a common function, which could all be combined into one.)

NOTE: The code enables figures to be exported, but parameters for exporting the figures are hard-coded within the functions, and may need some manual adjustment depending on the networks being plotted and the coordinates used.
