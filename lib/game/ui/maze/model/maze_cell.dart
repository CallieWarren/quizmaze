class MazeCell {
  bool isVisitedByPlayer = false;
  bool isVisitedForGenerate = false;
  bool isWallRight = false;
  bool isWallLeft = false;
  bool isWallTop = false;
  bool isWallBottom = false;
  var neighbors = List<MazeCell>.empty(growable: true);

  void visit() {
    isVisitedByPlayer = true;
  }

  bool isRevisitOption() {
    int unvisitedNeighbors = 0;
    for (var cell in neighbors) {
      if(!cell.isVisitedByPlayer) {
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