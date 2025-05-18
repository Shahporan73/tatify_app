String reviewFormat(double? star) {
  if (star == null) return 'No ratings yet';

  if (star >= 4.5) return 'Excellent';
  if (star >= 3.5) return 'Good';
  if (star >= 2.5) return 'Average';
  if (star >= 1.5) return 'Below Average';
  if (star > 0) return 'Poor';

  return 'No ratings yet';
}
