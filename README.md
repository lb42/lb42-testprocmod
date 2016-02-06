#TEI Processing Model Test suite#

**Warning:** *work in progress*

File testprocmod.odd contains an odd which should include a processing
model that exercises all the behaviours listed in the spec for &lt;model>

To compile the corresponding XSLT, use oXyGen to define a validation
scenario that uses the file XSL/pm_oddtoxsl.xsl (other XSLT files in
the same directory are included by this one)

The result is file testprocmod.xsl which should convert a TEI-XML file
conforming to the testprocmod.rnc schema into HTML.

testprocmod.xml is a silly test file; associate it with testprocmod.xsl to
see if anything works.



