//
//  ICA.swift
//

import Foundation

public func fx_inv(x : Double, par: Double) -> Double
{
    return (1.0 / x);
}

public func fx_div_c(x : Double, par: Double) -> Double
{
    return (x / par);
}

// TODO: Would work via optimized functions
public func fx_inv_sqrt(x : Double, par: Double) -> Double
{
    return (1/sqrt(x));
}

public func fx_1sub_sqr(x : Double, par: Double) -> Double
{
    return (par * (1-x*x));
}

public func fx_tanh(x : Double, par: Double) -> Double
{
    return tanh(par * x);
}


public func fx_rand(x : Double, par: Double) -> Double
{
    return Double(arc4random())/Double(RAND_MAX);
}

public func fastICA(_X: Matrix<Double>, compc: Int) -> (K: Matrix<Double>, W: Matrix<Double>, A: Matrix<Double>, S: Matrix<Double>){
    
    let rows = _X.rows
    let cols = _X.columns
    
    
    // Centering
    var (X, scale) = centerColumns(x:_X)
    
    // Whitening
    // X <- t(X); V <- X %*% t(X)/rows
    var XT = transpose(X)
    X = applyFunc(x:X, par:Double(X.rows), function:fx_div_c)
    
    var V = mul(XT, X)
           
    // SVD
    
//    var svdRtn = svdcmp(V)
    var svdRtn = fastsvd(A: V)
    assert(svdRtn.error == 0)
    
    var d = svdRtn.W!
    V = svdRtn.U!
    var D = svdRtn.V!
    
    // D <- diag(c(1/sqrt(d))
    d = applyFunc(x:d, par: 0.0, function:fx_inv_sqrt);
    D = Matrix(diagonalMatrixwithVector: d)
    
    // K <- D %*% t(U)
    var TU = transpose(V)
    V = mul(D, TU)
    
    // X1 <- K %*% X
    var X1 = mul(V, XT);
    
    // FAST ICA
    
    var _A = ICACompute(X1, compc, rows)
    
    // OUTPUT
    
    // X <- t(x)
    X = transpose(XT)
    X = deCenterColumns(X, scale)
    
    // K
    var K = transpose(V)
    
    // w <- a %*% K; S <- w %*% X
    D = mul(_A, V)
    X1 = mul(D, XT)

    // S
    var S = transpose(X1)
    
    // A <- t(w) %*% solve(w * t(w))
    TU = transpose(D)
    V = mul(D, TU)
    D = inv(V)
    V = mul(TU, D)
    
    // A
    var A = transpose(V)
    
    // W
    var W = transpose(_A)
    
    return (K,W,A,S)
    
    
}

public func ICACompute(_ _X : Matrix<Double>, _ rows: Int, _ cols: Int) -> Matrix<Double> {
    
    var MAX_ITERATIONS = 1000
    var TOLERANCE = 0.0001
    var ALPHA = 1
    var X = _X;
    
    // W rand init
    var W = Matrix(rows: rows, columns: rows, repeatedValue: 0.0)
    W = applyFunc(x:W, par:0.0, function:fx_rand);
    
    // sW <- La.svd(W)
    var Wd = W
//    var svdRtn = svdcmp(Wd)
    var svdRtn = fastsvd(A: Wd)
    assert(svdRtn.error == 0)
    
    var d = svdRtn.W!
    Wd = svdRtn.U!
    var D = svdRtn.V!
    
    // W <- sW$u %*% diag(1/sW$d) %*% t(sW$u) %*% W
    var TU = transpose(Wd)
    d = applyFunc(x:d, par:0.0, function:fx_inv);
    D = Matrix(diagonalMatrixwithVector: d)
    var TMP = mul(Wd, D)
    D = mul(TMP, TU)
    Wd = mul(D, W)
    
    // W1 <- W
    var W1 = Wd
    
    // lim <- rep(1000, maxit); it = 1
    var lim = Array<Double>(repeating: 1000, count: MAX_ITERATIONS)
    var it : Int = 0
    
    
    // t(X)/p
    var TXp = transpose(X)
    TXp = applyFunc(x: TXp, par: Double(cols), function: fx_div_c)
    
    
    while (lim[it] > TOLERANCE && it < MAX_ITERATIONS) {
        
        // wx <- W %*% X
        var GWX = mul(Wd, X);
        
        // gwx <- tanh(alpha * wx)
        GWX = applyFunc(x: GWX, par: Double(ALPHA), function: fx_tanh)
        
        // v1 <- gwx %*% t(X)/p
        TMP = mul(GWX, TXp)
        
        // g.wx <- alpha * (1 - (gwx)^2)
        GWX = applyFunc(x: GWX, par: Double(ALPHA), function: fx_1sub_sqr)
        
        // v2 <- diag(apply(g.wx, 1, FUN = mean)) %*% W
        d = meanOfRows(x: GWX)
        D = Matrix(diagonalMatrixwithVector: d)
        TU = mul(D, Wd)
        
        // W1 <- v1 - v2
        W1 = TMP + (-1.0 * TU)
        
        // sW1 <- La.svd(W1)
        W = W1
        
//        var svdRtn = svdcmp(W)
        var svdRtn = fastsvd(A: W)
        
        assert(svdRtn.error == 0)
        
        var d = svdRtn.W!
        W = svdRtn.U!
        var D = svdRtn.V!
        
        // W1 <- sW1$u %*% diag(1/sW1$d) %*% t(sW1$u) %*% W1
        TU = transpose(W)
        d = applyFunc(x: d, par: 0.0, function: fx_inv);
        D = Matrix(diagonalMatrixwithVector: d)

        TMP = mul(W,D)
        D = mul(TMP, TU)
        W = mul(D,W1)
        
        // lim[it + 1] <- max(Mod(Mod(diag(W1 %*% t(W))) - 1))
        TU = transpose(Wd)
        TMP = mul(W, TU)
        
        if( (it+1) < MAX_ITERATIONS ){
            lim[it+1] = fabs(maxDiag(x: TMP) - 1);
        }else{
            break
        }
        // W <- W1
        Wd = W
        
        it += 1;
    }
    
    return Wd
    
}

