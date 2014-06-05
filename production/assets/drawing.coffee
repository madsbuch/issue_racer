jQuery ->

  numberOfIssues = [0..9]
  numberOfRunners = [0..2]

  iso = new Isomer(document.getElementById("art"))


  Shape = Isomer.Shape
  Point = Isomer.Point
  Path  = Isomer.Path
  Color = Isomer.Color
  red = new Color(160, 60, 50)
  blue = new Color(50, 60, 160)
  white = new Color(255, 255, 255)

  iso.add(
    new Path([
      Point(-1,0,0)
      Point(10,0,0)
      Point(10,5,0)
      Point(-1,5,0)]
    )
    , new Color(181, 90, 60)
  )

  for i in numberOfRunners
    iso.add(
      new Path([
        Point(-1,0.1,1)
        Point(-1,0.2,1)
        Point(10,0.2,1)
        Point(10,0.1,1)
      ])
      .translate(-2,0.45+i,1)
      , white
    )

  drawHedge = (_iso,x,y,z) ->
    _iso.add(
      Shape.Prism(new Point(x,y,z), 1,1,3)
      .scale(new Point(x,y,z), 0.1, 0.1, 0.1)
      , blue
    )

    _iso.add(
      Shape.Prism(new Point(x,y+5,z), 1,1,3)
      .scale(new Point(x,y,z), 0.1, 0.1, 0.1)
      , blue
    )

    _iso.add(
      Shape.Prism(new Point(x,y,z+3), 1,6,1)
      .scale(new Point(x,y,z), 0.1, 0.1, 0.1)
      , red
    )

  for issue in numberOfIssues
    $('.application-container').append """
      <div class="hedge">
        <canvas width="100" height="100" id="hedge-#{issue}">

        </canvas>
      </div>
    """

  for issue in numberOfIssues
    hedgeIso = new Isomer(document.getElementById("hedge-#{issue}"))

    drawHedge(hedgeIso,1,1,-1)



