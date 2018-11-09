library(cgdsr)

mycgds = CGDS("http://www.cbioportal.org/public-portal/")

test(mycgds)
getClinicalData(mycgds)

cancerStudies = getCancerStudies(mycgds)
interestedCancerStudies = cancerStudies[1:4,]

oneCaseList = getCaseLists(mycgds)
