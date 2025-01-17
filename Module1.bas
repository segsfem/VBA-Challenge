Attribute VB_Name = "Module1"
Sub multiple_year_stock()

'loop for all ws

Dim ws As Worksheet
    For Each ws In Worksheets

'Define lastrow
   
    
    Dim lastrow As Double
    
    'Determine last row
        lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    'create summary table to keep track of trackername, price change, percentage change & total stock volume
    Dim Summary_table_row As Double
    Summary_table_row = 2
    
    'definition of all variables
    Dim Tickername As String
    Dim Pricechange As Double
    Pricechange = 0
    Dim OpeningPrice As Double
    OpeningPrice = 0
    Dim ClosingPrice As Double
    ClosingPrice = 0
    Dim PercentagePrice As Double
    PercentagePrice = 0
    Dim StockVolume As Double
    Dim Max_TickerName As String
    Max_TickerName = " "
    Dim Min_TickerName As String
    Min_TickerName = " "
    Dim Max_Percentage As Double
    Max_Percentage = 0
    Dim Min_Percentage As Double
    Min_Percentage = 0
    Dim Max_VolTicker As String
    Max_VolTicker = " "
    Dim Max_Stockvolume As Double
    Max_Stockvolume = 0
    
    'Add heading for each summary
    ws.Cells(1, 9).Value = "Ticker"
    ws.Cells(1, 10).Value = "Yearly Change"
    ws.Cells(1, 11).Value = "Percentage Change"
    ws.Cells(1, 12).Value = "Total Stock Volume"
    ws.Cells(1, 16).Value = "Ticker"
    ws.Cells(1, 17).Value = "Value"
    ws.Cells(2, 15).Value = "Greatest % Increase"
    ws.Cells(3, 15).Value = "Greatest % Decrease"
    ws.Cells(4, 15).Value = "Greatest Total Volume"
    
    
     'Set intial open price
        
    OpeningPrice = ws.Cells(2, 3).Value

        'Create loop through all ticker symbol
     For i = 2 To lastrow
           
           ' set ticker name
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
            
            Tickername = ws.Cells(i, 1).Value
            
            'set yearly price change and percentage change
            ClosingPrice = ws.Cells(i, 6).Value
            Pricechange = ClosingPrice - OpeningPrice
            
                If OpeningPrice <> 0 Then
                         
                PercentagePrice = (Pricechange / OpeningPrice) * 100
                
                End If
                
                'stock volume
            StockVolume = StockVolume + ws.Cells(i, 7).Value
            
            'formatting
            ws.Range("i" & Summary_table_row).Value = Tickername
            
            ws.Range("j" & Summary_table_row).Value = Pricechange
             If (Pricechange > 0) Then
             ws.Range("j" & Summary_table_row).Interior.ColorIndex = 4
             
             ElseIf (Pricechange <= 0) Then
             ws.Range("j" & Summary_table_row).Interior.ColorIndex = 3
             
             End If
             
            ws.Range("k" & Summary_table_row).Value = (Str(PercentagePrice) & "%")
 
            
            ws.Range("l" & Summary_table_row).Value = StockVolume
                      
            
            Summary_table_row = Summary_table_row + 1
            
            Pricechange = 0
            
            ClosingPrice = 0
            
            
            
            OpeningPrice = ws.Cells(i + 1, 3).Value
            
            'Bonus question
                If (PercentagePrice > Max_Percentage) Then
                
                    Max_Percentage = PercentagePrice
                    Max_TickerName = Tickername
                    
                ElseIf (PercentagePrice < Min_Percentage) Then
                    Min_Percentage = PercentagePrice
                    Min_TickerName = Tickername
                End If
            
                If (StockVolume > Max_Stockvolume) Then
                    Max_Stockvolume = StockVolume
                    Max_VolTicker = Tickername
                    
                End If
                
            PercentagePrice = 0
            
            StockVolume = 0
            
            Else
            
            StockVolume = StockVolume + ws.Cells(i, 7).Value
            
            End If
            
            Next i
            
                'record of bonus question
            ws.Range("q2").Value = (Str(Max_Percentage) & "%")
            ws.Range("q3").Value = (Str(Min_Percentage) & "%")
            ws.Range("p2").Value = Max_TickerName
            ws.Range("p3").Value = Min_TickerName
            ws.Range("q4").Value = Max_Stockvolume
            ws.Range("p4").Value = Max_VolTicker
            
               
        Next ws



End Sub

