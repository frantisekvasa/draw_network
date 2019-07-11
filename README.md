# Code to draw (brain) networks from three angles, as "ball-and-stick" diagrams

There are four versions of this function:

*draw_network*              colored nodes + simple black lines as edges
*draw_network_sig*          as above, with option to make certain (eg: "non-significant") nodes transparent
*draw_network_edgecol*      colored nodes + colored edges
*draw_network_sig_edgecol*  as above, with option to make certain (eg: "non-significant") nodes transparent

(These are all special cases of a common function, which could all be combined into one.)