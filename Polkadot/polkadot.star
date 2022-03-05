load("render.star", "render")
load("http.star", "http")
load("encoding/base64.star", "base64")
load("humanize.star", "humanize")
load("math.star", "math")
load("time.star", "time")

KRAKEN_PRICE_URL = "https://api.kraken.com/0/public/Ticker?pair=DOTUSD"   

DOT_ICON = base64.decode("""
iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAN1JREFUWEftl8sOgyAQRYdP04X9ZrvQT6OhCQklzONOadEEl2K8h8PwCjT4CYPzaQLc00Bc9sjVTjgfUKegj6XgGsgKYgZAwjOMBcIE4Am3QqgAbPixfVpfn+ySIpkQAZrhZXAZmt8zIBwEBqCEkNAOA7C9F1S/xyBBABZYA9cHaPXUUQd+AzWAVh9E1KoDDKAc43oapjalPvoA5NkuFBuyT+AG/gWQcsQlGDQArwOXABAhSgOKDfdekId76G74DUS384AHwhKe/queB1pzetiZ8BeXGJeBniATYBp4AVgJgiHcaN7/AAAAAElFTkSuQmCC
""")

def main():
    
    print(time.now())
    print("Calling Kraken API.")
    rep = http.get(KRAKEN_PRICE_URL)
    if rep.status_code != 200:
        fail("Kraken request failed with status %d", rep.status_code)
    rate = float(rep.json()["result"]["DOTUSD"]["a"][0])
    startRate = float(rep.json()["result"]["DOTUSD"]["o"])
    trend = "#0f0" if float(rate) >= float(startRate) else "#f00"
    formattedRate = humanize.float("##.##",rate)
    	

    return render.Root(
        child = render.Box(
            render.Row(
                expanded=True,
                main_align="space_evenly",
                cross_align="center",
                children = [
                    render.Image(src=DOT_ICON),
                    render.Text(content="$%s" % (formattedRate), color=trend),
                ],
            ),
        ),
    )