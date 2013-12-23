CT_Scanner
==========

Virtual CT Scanner using matlab

1. Start the code CT_Scaner.m, you will get the opening GUI.

2. In the Configuration area, you could select Circular (X, Y, R), Rectangular (X, Y, X’, Y’) or Matlab phantom (“Modified Shepp-Logan”) to add into the Phantom area with legal position and Grayscale (0.0 ~ 1.0). Check will check the correctness of position, after checking, Generate will be enabled.

3. Then after checking, you could hit Process to start the Result GUI. Note that if you choose to add a Matlab phantom, you could only directly hit Process. A Reset button will clear the cache and restart the CT_Scaner.

4. When you Process, Result GUI will pop up and show the original and reconstructed images. Then you could set the Number of transducers, Angular increment and the Type of transducer to Reconstruct. A Default button will set these three parameters to the default ones (3, 5, arc).

5. After you reconstructed the image, you could hit “Analyze !” to start the analysis.
