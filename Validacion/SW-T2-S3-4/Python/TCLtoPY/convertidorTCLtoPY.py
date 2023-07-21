
exec(open('toOpenSeesPy.py').read())

outfile_Model = open('SW-T2-S3-4_Model.py','w')
outfile_Recorders = open('SW-T2-S3-4_Recorders.py','w')
outfile_HorizAnalysis = open('SW-T2-S3-4_HorizontalAnalysis.py','w')
outfile_VertAnalysis = open('SW-T2-S3-4_VerticalAnalysis.py','w')

outfile_Model.write('import opensees as ops\n\n')
outfile_Recorders.write('import opensees as ops\n\n')
outfile_HorizAnalysis.write('import opensees as ops\n\n')
outfile_VertAnalysis.write('import opensees as ops\n\n')

toOpenSeesPy('Model_SWT2S34.tcl',outfile_Model,'ops')
toOpenSeesPy('Recorders_SWT2S34.tcl',outfile_Recorders,'ops')
toOpenSeesPy('SW_S34_HorizontalLoad.tcl',outfile_HorizAnalysis,'ops')
toOpenSeesPy('SW_S34_StaticHorizontalAnalysis.tcl',outfile_HorizAnalysis,'ops')
toOpenSeesPy('SW_S34_VerticalLoad.tcl',outfile_VertAnalysis,'ops')
toOpenSeesPy('SW_S34_StaticVerticalAnalysis.tcl',outfile_VertAnalysis,'ops')

outfile_Model.close()
outfile_Recorders.close()
outfile_HorizAnalysis.close()
outfile_VertAnalysis.close()
