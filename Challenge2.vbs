Sub easyOption()

    ' Set Dimensions
    Dim total As Double
    Dim j As Integer
    Dim Ticker As String
    Dim OpenPrice As Double
    Dim ClosePrice As Double
    Dim YearlyChange As Double
    Dim PercentChange As Double
    Dim TotalVolume As Long
    Dim LastRow As Long
    Dim i As Long
    Dim Year As Integer
    Dim WS_Count As Integer
    Dim ws As Worksheet
    Dim maxPercentIncrease As Double
    Dim maxPercentIncreaseTicker As String
    Dim minPercentDecrease As Double
    Dim minPercentDecreaseTicker As String
    Dim maxTotalVolume As Double
    Dim maxTotalVolumeTicker As String
    Dim changeRange As Range
    Dim cond1 As FormatCondition, cond2 As FormatCondition
         
    ' Set WS_Count equal to the number of worksheets in the active workbook.
    WS_Count = ActiveWorkbook.Worksheets.Count

    'MsgBox Application.Sheets.Count
    
    For Each ws In Worksheets

    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"
    ws.Range("P1").Value = "Ticker"
    ws.Range("Q1").Value = "Value"
    ws.Range("O2").Value = "Greatest % Increase"
    ws.Range("O3").Value = "Greatest % Decrease"
    ws.Range("O4").Value = "Greatest Total Volume"

    ' Set variables for each sheet
    total = 0
    j = 0
    
    ' Get the row number of the last row with data
    RowCount = ws.Cells(Rows.Count, "A").End(xlUp).Row

    ' Set title row
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"

    Start = 2

    For i = 2 To RowCount

    ' If ticker changes then print results
    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
    
    ' Print ticker symbol
    ws.Range("I" & 2 + j).Value = ws.Cells(i, 1).Value
    total = total + ws.Cells(i, 7).Value
    
    ' Print total
    ws.Range("L" & 2 + j).Value = total
    ' For yearly change and percentage change
    YearlyChange = ws.Cells(i, 6) - ws.Cells(Start, 3)
    PercentChange = YearlyChange / ws.Cells(Start, 3)
    Start = i + 1
    ws.Range("J" & 2 + j).Value = YearlyChange
    ws.Range("J" & 2 + j).NumberFormat = "0.00"
    ws.Range("K" & 2 + j).Value = PercentChange
    ws.Range("K" & 2 + j).NumberFormat = "0.00%"
    If ws.Range("J" & 2 + j).Value > 0 Then
    ws.Range("J" & 2 + j).Interior.ColorIndex = 4
    ElseIf ws.Range("J" & 2 + j).Value < 0 Then
    ws.Range("J" & 2 + j).Interior.ColorIndex = 3
    End If
    YearlyChange = 0
    PercentChange = 0
    
    ' Rest total
    total = 0
    
    ' Move to next row
    j = j + 1
    
    ' Else keep adding to the total volume
    Else
         total = total + ws.Cells(i, 7).Value
    End If

    ' Loop through each row of data and find the stock with the greatest percentage increase
        If ws.Cells(i, "K").Value > maxPercentIncrease Then
            maxPercentIncrease = ws.Cells(i, "K").Value
            maxPercentIncreaseTicker = Cells(i, "I").Value
        End If
    
    ' Print the results on cells P2 and Q2
    ws.Range("P2").Value = maxPercentIncreaseTicker
    ws.Range("Q2").Value = Format(maxPercentIncrease, "0.00%")

    ' Initialize the minPercentDecrease variable to a large number so that the first percentage decrease value will be less than it
    minPercentDecrease = 4000
    
    ' Loop through each row of data and find the stock with the greatest percentage decrease
        If ws.Cells(i, "K").Value < minPercentDecrease Then
            minPercentDecrease = ws.Cells(i, "K").Value
            minPercentDecreaseTicker = ws.Cells(i, "I").Value
        End If
    
    ' Print the results on cells P3 and Q3
    ws.Range("P3").Value = minPercentDecreaseTicker
    ws.Range("Q3").Value = Format(minPercentDecrease, "0.00%")

    ' Loop through each row of data and find the stock with the greatest total volume
        If ws.Cells(i, "L").Value > maxTotalVolume Then
            maxTotalVolume = ws.Cells(i, "L").Value
            maxTotalVolumeTicker = ws.Cells(i, "I").Value
        End If
    
    ' Print the results on cells P4 and Q4
    ws.Range("P4").Value = maxTotalVolumeTicker
    ws.Range("Q4").Value = maxTotalVolume

    Next i

        Next ws

End Sub