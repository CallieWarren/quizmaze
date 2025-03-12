class MazeCell {
  bool isVisited = false;
  bool isRevisitOption = false;
  bool isWallRight = false;
  bool isWallLeft = false;
  bool isWallTop = false;
  bool isWallBottom = false;
  var neighbors = [];


  void visit() {
    isVisited = true;
    var neighborOptions = neighbors.takeWhile((element) => !(element as MazeCell).isVisited);
    isRevisitOption = neighborOptions.length > 1;
  }

  MazeCell();
}