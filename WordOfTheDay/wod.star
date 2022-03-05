load("render.star", "render")
load("http.star", "http")
load("cache.star", "cache")
load("time.star", "time")
load("encoding/json.star", "json")

def main(args):
    today = time.now().format("2006-01-02")
    wordnikKey = args["apiKey"]
    WORDNIK_URL = "https://api.wordnik.com/v4/words.json/wordOfTheDay?date=%s&api_key=%s" % (today,wordnikKey)

    print("%s Calling Wordnik API" % today)
    resp = http.get(WORDNIK_URL)
    if resp.status_code != 200:
        fail("Wordnik request failed with status %d", resp.status_code)
    wod = json.decode(resp.body())
    
    word = wod["word"]
    pos = wod["definitions"][0]["partOfSpeech"]
    defi = wod["definitions"][0]["text"]
    

    return render.Root(
        delay = 100,
        child = render.Column(
            children = [
                render.Text(content = word.title(), font = "tb-8", color = "#94F"),
                render.Box(width = 64, height = 1, color = "#D00"),
                render.Text(content = " " + pos.title(), font = "tom-thumb", color = "#94F"),
                render.Box(width = 64, height = 1, color = "#D44"),
                render.Marquee(width = 64, child = render.Text(content = defi, color = "#94F")),
            ],
        )
    )



