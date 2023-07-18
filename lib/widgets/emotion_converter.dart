int emotionConverter(int emotion) {
  switch (emotion) {
    case 0: return 4;
    case 1: return 5;
    case 2: return 3;
    case 3: return 2;
    case 4: return 0;
    case 5: return 1;
    case 6: return 6;
  }
  return 0;
}