load("render.star", "render")
load("http.star", "http")
load("encoding/base64.star", "base64")
load("time.star", "time")
load("encoding/json.star", "json")
load("math.star", "math")

TESLAMATE_URL = "https://teslamate.meettheparks.com/api/v1/cars/1/status"
TESLA_ICON = base64.decode("""/9j/4AAQSkZJRgABAQEAYABgAAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAZAAA/+EDQmh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8APD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4NCjx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMDE0IDc5LjE1Njc5NywgMjAxNC8wOC8yMC0wOTo1MzowMiAgICAgICAgIj4NCgk8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPg0KCQk8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxNCAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozMkVEOUM5QTdFRDExMUU2OTdENzhBOUE2OEE3MzRDRiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozMkVEOUM5QjdFRDExMUU2OTdENzhBOUE2OEE3MzRDRiI+DQoJCQk8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDozMkVEOUM5ODdFRDExMUU2OTdENzhBOUE2OEE3MzRDRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDozMkVEOUM5OTdFRDExMUU2OTdENzhBOUE2OEE3MzRDRiIvPg0KCQk8L3JkZjpEZXNjcmlwdGlvbj4NCgk8L3JkZjpSREY+DQo8L3g6eG1wbWV0YT4NCjw/eHBhY2tl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""")

def main(args): 
    print("%s Calling Teslamate API" % time.now())
    resp = http.get(TESLAMATE_URL,auth=(args["tmUser"],args["tmPw"]))
    if resp.status_code != 200:
        fail("Teslamate request failed with status %d", resp.status_code)
    payload = json.decode(resp.body())
    
    odoRaw = payload["data"]["status"]["odometer"]
    batt = payload["data"]["status"]["battery_details"]["battery_level"]
    version =  payload["data"]["status"]["car_versions"]["version"]
    
    
    odo = int(odoRaw)
    if int(batt) < 30: 
	chargeLevel = "#f00"
    elif int(batt) >= 30 and int(batt) < 70:
	chargeLevel = "#dc3"
    elif int(batt) >= 70:
	chargeLevel = "#0f0"

    return render.Root(
        render.Column(
            children = [
                render.Box(
                        width = 64, 
                        height = 16, 
                        child = render.Column(
				expanded = True,
				cross_align ="start",
                                children = [
                                    render.Row(
					expanded = True,
					cross_align ="start",
                                	children = [
                                            render.Box(width = 16, height = 16 , child = render.Image(src=TESLA_ICON,width = 16, height = 16,)),
                                            render.Box(
						width = 48, 
						height = 16, 
						child = render.Column(
							 children = [
                                    				render.Row(
									expanded = True,
									cross_align ="start",
                                					children = [render.Box(width = 48, height = 8 , child = render.Text(content = "Bianca", color ="#8DF")),],
								),

				    				render.Row(
									expanded = True,
									cross_align ="start",
                                					children = [render.Box(width = 48, height = 8 , child = render.Text(content = "Bat: %d%s" % (batt,"%"),color = chargeLevel)),],
                                    				),
                                			]
						
							)
						),
                                            ],
                                    )
                                ]
                            ),
                        ),
                render.Box(
                        width = 64, 
                        height = 16, 
                        child = render.Column(
				expanded = True,
				cross_align ="start",
                                children = [
                                    render.Row(
					expanded = True,
					cross_align ="start",
                                	children = [render.Box(width = 64, height = 8 , child = render.Text(content = "Odo: %d" % odo, color = "#9AE")),],
					),

				    render.Row(
					expanded = True,
					cross_align ="start",
                                	children = [render.Box(width = 64, height = 8 , child = render.Text(content = "Fw: %s" % version, color = "#9AE")),],
                                    ),
                                ]
                            ),
                        ),
                ]
        )
    ) 