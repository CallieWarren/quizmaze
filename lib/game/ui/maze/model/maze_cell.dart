class MazeCell {
  bool isVisited = false;
  bool isRevisitOption = false;
  bool isWallRight = false;
  bool isWallLeft = false;
  bool isWallTop = false;
  bool isWallBottom = false;
  var neighbors = List<MazeCell>.empty(growable: true);



  void visit() {
    isVisited = true;
    var neighborOptions = neighbors.takeWhile((element) => !(element).isVisited);
    isRevisitOption = neighborOptions.length > 1;
  }

  void addNeighbor(MazeCell neighbor) {
    neighbors.add(neighbor);
  }

  MazeCell();
}