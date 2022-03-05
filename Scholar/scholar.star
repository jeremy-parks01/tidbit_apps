load("render.star", "render")
load("http.star", "http")
load("encoding/base64.star", "base64")
load("time.star", "time")
load("encoding/json.star", "json")


def main(args): 
    SERP_API_URL = "https://serpapi.com/search.json?engine=google_scholar_author&author_id=3kSNt8wAAAAJ&hl=en&api_key=%s" % args["apiKey"]
    HAT = base64.decode("""iVBORw0KGgoAAAANSUhEUgAAASwAAAD6CAYAAAAbbXrzAAAAAXNSR0IArs4c6QAACuRJREFUeAHt3T+OHEUUB2AvMiEhB3DmaDmDJc7AITkDki9AgiNnvgEJIcGyIrBmpZ6a113/Xld/ROvurqpX35v9qYPa4d07/xEgQIAAAQIECBAgQIAAAQIECBAgQIAAAQIECBAgQIAAAQIECBAgQIAAAQIECBAgQIAAgUwCT5mKUcspBF6SV+kznbxBNeX9UDPYWAIECIwUEFgjta1FgECVgMCq4jOYAIGRAgJrpLa1CBCoEhBYVXwGEyAwUkBgjdS2FgECVQICq4rPYAIERgoIrJHa1iJAoEpAYFXxGUyAwEgBp4JHas9Zq+nJ9Ofn5zm7CK765cuX4JPhx/yOhKn6P+gNq7+xFQgQaCQgsBpBmoYAgf4CAqu/sRUIEGgkILAaQZqGAIH+AgKrv7EVCBBoJCCwGkGahgCB/gICq7+xFQgQaCQgsBpBmoYAgf4CAqu/sRUIEGgk4BRvI8iG01zqZHpDty5TOTnfhfXwpN6wDtMZSIDAaAGBNVrcegQIHBYQWIfpDCRAYLSAwBotbj0CBA4LCKzDdAYSIDBaQGCNFrceAQKHBQTWYToDCRAYLSCwRotbjwCBwwIC6zCdgQQIjBZw0r1e3Mn0esPLzODkfF2rvWHV+RlNgMBAAYE1ENtSBAjUCQisOj+jCRAYKCCwBmJbigCBOgGBVednNAECAwUE1kBsSxEgUCcgsOr8jCZAYKCAwBqIbSkCBOoEBFadn9EECAwUuOJJdyfTB37ALNVX4Gon571h9f08mZ0AgYYCAqshpqkIEOgrILD6+pqdAIGGAgKrIaapCBDoKyCw+vqanQCBhgICqyGmqQgQ6CsgsPr6mp0AgYYCAqshpqkIEOgrILD6+pqdAIGGAmc46e5kesOGm4pASSD7yXlvWKXuuUeAQCoBgZWqHYohQKAkILBKOu4RIJBKQGClaodiCBAoCQisko57BAikEhBYqdqhGAIESgICq6TjHgECqQQEVqp2KIYAgZKAwCrpuEeAQCqBHifdnUxP1eK2xXz+/LnthMHZPn36FHzSY5kEdpycD2WRN6xM3VULAQJFAYFV5HGTAIFMAgIrUzfUQoBAUUBgFXncJEAgk4DAytQNtRAgUBQQWEUeNwkQyCQgsDJ1Qy0ECBQFBFaRx00CBDIJCKxM3VALAQJFgffFu8duhk6svk4dOhEfPSn7/Px8rFqjCBD4LhD9ffs+4PEP0Tx4PNPrE96wQkweIkAgg4DAytAFNRAgEBIQWCEmDxEgkEFAYGXoghoIEAgJCKwQk4cIEMggILAydEENBAiEBARWiMlDBAhkEBBYGbqgBgIEQgICK8TkIQIEMgg0PYU6eUOhk/OzTsT/9fs/k3nGLv/3z382XdB3utdx7jjBnjoTvGHVfQ6MJkBgoIDAGohtKQIE6gQEVp2f0QQIDBQQWAOxLUWAQJ2AwKrzM5oAgYECAmsgtqUIEKgTEFh1fkYTIDBQQGANxLYUAQJ1AgKrzs9oAgQGCqQ+1brH4eXrh9BJ9z1ztnz2l99+ajmduQj8L7DKCfZoO71hRaU8R4DAdAGBNb0FCiBAICogsKJSniNAYLqAwJreAgUQIBAVEFhRKc8RIDBdQGBNb4ECCBCICgisqJTnCBCYLiCwprdAAQQIRAUEVlTKcwQITBdIf9I9eoL96eO3WXsJnbCf9V3y0z9hCngjsONk+ptxhX/M+twXSup3yxtWP1szEyDQWEBgNQY1HQEC/QQEVj9bMxMg0FhAYDUGNR0BAv0EBFY/WzMTINBYQGA1BjUdAQL9BARWP1szEyDQWEBgNQY1HQEC/QQEVj9bMxMg0Fhg2inZ6An26H6zn3SP7sOJ+KhUruecYB/TD29YY5ytQoBAAwGB1QDRFAQIjBEQWGOcrUKAQAMBgdUA0RQECIwREFhjnK1CgEADAYHVANEUBAiMERBYY5ytQoBAAwGB1QDRFAQIjBEQWGOcrUKAQAOB9w3mODbFr/8eG3fSUdET7K1PTEfXPSlr97Kj/Wjt/Lpu6P8V8Aow7a9VuuNvLOANawPFJQIEcgoIrJx9URUBAhsCAmsDxSUCBHIKCKycfVEVAQIbAgJrA8UlAgRyCgisnH1RFQECGwICawPFJQIEcgoIrJx9URUBAhsCAmsDxSUCBHIKzDvp/sePMREn4mNOd56adVL7TjndL0f3Gy2k9Qn26Lqe2xbwhrXt4ioBAgkFBFbCpiiJAIFtAYG17eIqAQIJBQRWwqYoiQCBbQGBte3iKgECCQUEVsKmKIkAgW0BgbXt4ioBAgkFBFbCpiiJAIFtAYG17eIqAQIJBaZ9H/TL1w/R76wOsT19/DZrL6F9ZD8xnf2EeLS+7M6hD/OOh6Iur1PO+v3YsZvHj3rDemzkCQIEkggIrCSNUAYBAo8FBNZjI08QIJBEQGAlaYQyCBB4LCCwHht5ggCBJAICK0kjlEGAwGMBgfXYyBMECCQREFhJGqEMAgQeCwisx0aeIEAgicC873RPAlAoY4kT7IX9vbnV+oT4jhPYb+q494/W9d1bx/XcAt6wcvdHdQQI3AgIrBsMPxIgkFtAYOXuj+oIELgREFg3GH4kQCC3gMDK3R/VESBwIyCwbjD8SIBAbgGBlbs/qiNA4EZAYN1g+JEAgdwCAit3f1RHgMCNgJPuNxh+bCfgZHo7y9JMUefXvzwI/eXG61qpv/vdG1bp0+AeAQKpBARWqnYohgCBkoDAKum4R4BAKgGBlaodiiFAoCQgsEo67hEgkEpAYKVqh2IIECgJCKySjnsECKQSEFip2qEYAgRKAgKrpOMeAQKpBJx0r2xH9LvLoyeSK8sxnMDSAt6wlm6vzRFYS0BgrdVPuyGwtIDAWrq9NkdgLQGBtVY/7YbA0gICa+n22hyBtQQE1lr9tBsCSwsIrKXba3ME1hIQWGv1024ILC0gsJZur80RWEvASff7/Wz63dY7vlP7fkUH7jhhv40W/QuF7dGnvNr08zxLwBvWLHnrEiCwW0Bg7SYzgACBWQICa5a8dQkQ2C0gsHaTGUCAwCwBgTVL3roECOwWEFi7yQwgQGCWgMCaJW9dAgR2Cwis3WQGECAwS0BgzZK3LgECuwWcdN9NdnjAlJPGs07YH1YaN3BKP8Ztb82VvGGt2Ve7IrCkgMBasq02RWBNAYG1Zl/tisCSAgJrybbaFIE1BQTWmn21KwJLCgisJdtqUwTWFBBYa/bVrggsKSCwlmyrTRFYU0BgrdlXuyKwpICT7ku29c2mnOh+w+EfZxbwhnXm7qmdwMUEBNbFGm67BM4sILDO3D21E7iYgMC6WMNtl8CZBQTWmbundgIXExBYF2u47RI4s4DAOnP31E7gYgIC62INt10CZxYQWGfuntoJXExAYF2s4bZL4MwCAuvM3VM7gYsJCKyLNdx2CZxZQGCduXtqJ3AxAYF1sYbbLoEzCwisM3dP7QQuJiCwLtZw2yVwZgGBdebuqZ3AxQQE1sUabrsEziwgsM7cPbUTuJhA+u/7fvn64SXSk6eP39LvJbIPzxAgcF/AG9Z9G3cIEEgmILCSNUQ5BAjcFxBY923cIUAgmYDAStYQ5RAgcF9AYN23cYcAgWQCAitZQ5RDgMB9AYF138YdAgSSCQisZA1RDgEC9wUE1n0bdwgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgUBP4DCu5/niFE8VcAAAAASUVORK5CYII=""")

    print("%s Calling SERP API" % time.now())
    resp = http.get(SERP_API_URL)
    if resp.status_code != 200:
        fail("SerpAPI request failed with status %d", resp.status_code)
    
    scholar = json.decode(resp.body())
    hIdx =  scholar["cited_by"]["table"][1]["h_index"]["all"]
    citations = scholar["cited_by"]["table"][0]["citations"]["all"]
    i10 = scholar["cited_by"]["table"][2]["i10_index"]["all"]
    

    return render.Root(
        child = render.Row(
            expanded=True,
            main_align="start",
            cross_align="end",
            children = [
                render.Column(
                    children=[   
			render.Box(width = 20, height = 16 , child = render.Image(src=HAT,width = 20, height = 16,)),                   
                        render.Box(width = 20, height = 16 , child = render.Text(content="",)),
                    ],
                ),

                render.Column(
		     main_align="start",
                    children=[
                        render.Box(width = 44, height = 8 , child = render.Text(content = "Dr. Parks", color = "#0B3")),
                        render.Box(width = 44, height = 8 , child = render.Text(content = "HIdx: %d" % (hIdx), color = "#FFF")),
                        render.Box(width = 44, height = 8 , child = render.Text(content = "Ctns: %d" % (citations), color = "#FFF")),
			render.Box(width = 44, height = 8 , child = render.Text(content = "i10: %d" % (i10), color = "#FFF")),
                    ],
                ),
            ]
         )
     )

