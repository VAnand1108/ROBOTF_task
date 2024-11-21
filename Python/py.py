import  requests

def highestInternationalStudents(firstCity, secondCity):
    url = 'https://jsonmock.hackerrank.com/api/universities'
    results = []
    page = 1
    while True:
        current_params = {
            'page': page
        }
        response = requests.get(url, params=current_params)
        result = response.json()
        if len(result['data']) == 0:
            break
        results.extend(result['data'])
        page += 1
    matchedUniv = {}
    univs = sorted(results, key=lambda x: int(x["international_students"].replace(",", "")), reverse=True)
    print(univs)
    for univ in univs:
        if (univ['location']['city'] == firstCity) or (univ['location']['city'] == secondCity):
            matchedUniv = univ
            break
        if not matchedUniv:
            matchedUniv = univs[0]
    return matchedUniv['university']
 
print(highestInternationalStudents('Singapore', 'pune'))