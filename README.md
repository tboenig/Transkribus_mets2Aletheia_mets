# Transkribus_mets2Aletheia_mets

Transform a METS file from Transkribus to Aletheia METS file (Page Collections file) and you can easily work with Aletheia.  
**See:** [Page Collections](https://www.primaresearch.org/www/assets/tools/Aletheia%20User%20Guide.pdf#page=123) in the Aletheia User Guide

Requirements for a METS file
------------
- The METS file from Transkribus ``mets.xml``. During document export the Mets file is created. The METS file is located in the main directory of the exported file folder.


Transformation
-------------------------------

```sh
java -jar ../saxon9he.jar -xsl:../xsl/Transkribus_mets2Aletheia_mets.xsl -s:../example/mets.xml -o: ../example/mets_aletheia.metsx
```

