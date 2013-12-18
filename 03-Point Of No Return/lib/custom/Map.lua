function Map:worldToTile(x, y)
  local tx, ty
  tx = math.floor(x / self.tileWidth)
  ty = math.floor(y / self.tileHeigth)
  return tx, ty
end
