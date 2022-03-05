load("render.star", "render")
load("http.star", "http")
load("time.star", "time")

def main(args): 
    OPENWEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?id=5744635&appid=%s&units=imperial" % args["apiKey"]
    print("%s Calling OpenWeather API" % time.now())
    currentReport = http.get(OPENWEATHER_URL)
    if currentReport.status_code != 200:
            fail("OpenWX request failed with status %d", currentReport.status_code)
    iconName = currentReport.json()["weather"][0]["icon"]
    iconUrl = "http://openweathermap.org/img/wn/%s@2x.png" % iconName
    temp = str(int(currentReport.json()["main"]["temp"]))
    humidity = str(int(currentReport.json()["main"]["humidity"]))
    low = str(int(currentReport.json()["main"]["temp_min"]))
    high = str(int(currentReport.json()["main"]["temp_max"]))
    windspeed = str(int(currentReport.json()["wind"]["speed"]))
    gust = str(int(currentReport.json()["wind"]["gust"]))

    winddir = int(currentReport.json()["wind"]["deg"])
    if winddir >= 0 and winddir < 23:
        cardinal = "N"
    elif winddir >= 23  and winddir < 67:
        cardinal = "NE"
    elif winddir >= 67  and winddir < 112:
        cardinal = "E"
    elif winddir >= 112  and winddir < 157:
        cardinal = "SE"
    elif winddir >= 157  and winddir < 202:
        cardinal = "S"
    elif winddir >= 202  and winddir < 247:
        cardinal = "SW"
    elif winddir >= 247  and winddir < 292:
        cardinal = "W"
    elif winddir >= 292  and winddir < 337:
        cardinal = "NW"
    elif winddir >= 337  and winddir <= 360:
        cardinal = "N"
    else:
        cardinal = "?"
    weatherIcon = http.get(iconUrl).body()

    return render.Root(
	delay = 500,
        child = render.Row(
            expanded=True,
            main_align="space_between",
            cross_align="end",
            children = [
                render.Column(
                    children=[                     
                        render.Box( width=32, height=16, child = render.Animation(children = [render.Image(src = weatherIcon,width = 16, height = 16,),],),),
                        render.Box(width = 32, height = 8 , child = render.Text(content = "Lo: " + low + "°", color = "#8DF")),
                        render.Box(width = 32, height = 8 , child = render.Text(content = "Hi: " + high + "°", color = "#D65")),

                    ],
                ),

                render.Column(
                    children=[
                        render.Box(width = 32, height = 14 , child = render.Text(content = temp + "°", color = "#584", font = "6x13")),
                        render.Box(width = 32, height = 8 , child = render.Text(content = humidity + "%", color = "#584", font = "5x8")),
                        render.Box(width = 32, height = 8 , child = render.Text(content = windspeed + " " + cardinal , color = "#584", font = "5x8")),
                    ],
                ),
            ]
         )
     )