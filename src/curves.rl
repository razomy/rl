#
Complex Numbers, Curves, Noise & Probability Distributions
#

Complex {
  Real      Float
  Imaginary Float
}

Rational {
  Numerator   Int
  Denominator Int & NonZeroNumber
}

IntervalMath {
  Min Float
  Max Float
} & [ _.Max >= _.Min ]

Polynomial {
  Coefficients List(Float)
}

LinearCurve       ICurve
DecelerateCurve   ICurve
InvertedCurve     ICurve
BounceInCurve     ICurve
BounceOutCurve    ICurve
BounceInOutCurve  ICurve
ElasticInCurve    ICurve & { Period Float }
ElasticOutCurve   ICurve & { Period Float }
ElasticInOutCurve ICurve & { Period Float }

CubicCurve ICurve & {
  X1         Float
  Y1         Float
  X2         Float
  Y2         Float
  ErrorBound Float
}

NoiseType   "Perlin" | "Simplex" | "Worley" | "Voronoi" | "Value" | "Gabor" | "Wavelet" | "White"
FractalType "None" | "FBM" | "Multifractal" | "HybridMultifractal" | "HeteroTerrain" | "RidgedMultifractal"

VoronoiParams {
  Scale       Float
  Detail      Float
  Roughness   Float
  Lacunarity  Float
  Smoothness  Float
  Exponent    Float
  Randomness  Float
  MaxDistance Float
  Normalize   Bool
  Feature     Int
  Metric      Int
}

VoronoiOutput {
  Distance Float
  Color    Float3
  Position Float4
}

NormalDistribution      { Mean Float, StdDev Float }
LogNormalDistribution   { Mu Float, Sigma Float }
UniformDistribution     { Min Float, Max Float }
ExponentialDistribution { Rate Float }
PoissonDistribution     { Lambda Float }
BinomialDistribution    { Trials Int, Probability Float }
BetaDistribution        { Alpha Float, Beta Float }
GammaDistribution       { Shape Float, Scale Float }
ChiSquaredDistribution  { DegreesOfFreedom Int }
StudentTDistribution    { DegreesOfFreedom Float }
ParetoDistribution      { Scale Float, Shape Float }

Distribution
  NormalDistribution | LogNormalDistribution | UniformDistribution | ExponentialDistribution
  | PoissonDistribution | BinomialDistribution | BetaDistribution | GammaDistribution
  | ChiSquaredDistribution | StudentTDistribution | ParetoDistribution
