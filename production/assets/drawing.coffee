jQuery ->

  numberOfIssues = [0..10]
  numberOfRunners = [0..1]

  iso = new Isomer(document.getElementById("art"), {originX: 0, originY: 0, scale : 50})


  Shape = Isomer.Shape
  Point = Isomer.Point
  Path  = Isomer.Path
  Color = Isomer.Color
  red = new Color(160, 60, 50)
  blue = new Color(50, 60, 160)
  white = new Color(255, 255, 255)

  # Scene
  iso.add(
    new Shape.Prism(new Point(0,2,0), numberOfIssues.length , 2 , 0.1)
    , new Color(181, 90, 60)
  )

  for i in numberOfRunners
    iso.add(
      new Path([
        Point(0.12,0.1,1)
        Point(0.12,0.2,1)
        Point(numberOfIssues.length+0.1,0.2,1)
        Point(numberOfIssues.length+0.1,0.1,1)
      ])
      .translate(-2,0.45+i,1)
      , white
    )

  drawHedge = (x,y,z) ->
    iso.add(
      Shape.Prism(new Point(x,y,z), 1,1,3)
      .scale(new Point(x,y,z), 0.1, 0.1, 0.1)
      , white
    )

    iso.add(
      Shape.Prism(new Point(x,y+5,z), 1,1,3)
      .scale(new Point(x,y,z), 0.1, 0.1, 0.1)
      , white
    )

    iso.add(
      Shape.Prism(new Point(x,y,z+3), 1,6,1)
      .scale(new Point(x,y,z), 0.1, 0.1, 0.1)
      , red
    )

  spacer = (numberOfIssues.length - 0.5 ) / numberOfIssues.length

  for issue in numberOfIssues
    drawHedge(issue*spacer+2 ,3.8,-1)



