class MazeCell {
  bool isVisited = false;
  bool isWallRight = false;
  bool isWallLeft = false;
  bool isWallTop = false;
  bool isWallBottom = false;
  var neighbors = List<MazeCell>.empty(growable: true);

  void visit() {
    isVisited = true;
  }

  bool isRevisitOption() {
    int unvisitedNeighbors = 0;
    for (var cell in neighbors) {
      if(!cell.isVisited) {
        unvisitedNeighbors = unvisitedNeighbors+1;
      }
    }
    return unvisitedNeighbors > 0;
  }

  void addNeighbor(MazeCell neighbor) {
    neighbors.add(neighbor);
  }

  MazeCell();
}