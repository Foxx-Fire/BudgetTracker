//
//  CustomPageControl.swift
//  BudgetTracker
//
//  Created by FoxxFire on 22.10.2025.
//
import UIKit

class CustomPageControl: UIView {
    
    // MARK: - Public Properties
    
    // Количество страниц в page control
    var numberOfPages: Int = 0 {
        didSet {
            // Когда меняется количество страниц:
            // 1. Нужно перерисовать view чтобы отобразить новые точки
            setNeedsDisplay()
            // 2. Сообщить системе что изменился внутренний размер
            //    чтобы автоматически обновились constraints
            invalidateIntrinsicContentSize()
        }
    }
    
    // Текущая активная страница (начинается с 0)
    var currentPage: Int = 0 {
        didSet {
            // Когда меняется текущая страница:
            // Просто перерисовываем view чтобы обновить внешний вид точек
            setNeedsDisplay()
        }
    }
    
    // MARK: - Private Constants
    
    // Размер обычной (неактивной) точки - диаметр круга
    private let dotSize: CGFloat = 6
    
    // Расстояние между центрами точек
    private let dotSpacing: CGFloat = 12
    
    // Ширина активной точки (прямоугольник)
    private let activeDotWidth: CGFloat = 14
    
    // MARK: - Initialization
    
    // Инициализация через код
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear // Прозрачный фон вместо черного
    }
    
    // Инициализация через Storyboard/XIB
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear // Прозрачный фон вместо черного
    }
    
    // MARK: - Layout
    
    // Этот метод сообщает системе о "естественном" размере view
    // AutoLayout использует эту информацию для расчета constraints
    override var intrinsicContentSize: CGSize {
        // Рассчитываем общую ширину:
        // 1. Все точки занимают: количество_точек × размер_точки
        let dotsWidth = CGFloat(numberOfPages) * dotSize
        
        // 2. Все промежутки занимают: (количество_точек - 1) × расстояние_между_точками
        let spacesWidth = CGFloat(numberOfPages - 1) * dotSpacing
        
        // 3. Активная точка шире обычной, поэтому добавляем разницу в ширину
        //    (активная_ширина - обычная_ширина)
        let activePointExtraWidth = (activeDotWidth - dotSize)
        // Максимальный сдвиг влево
        let leftOffset = activePointExtraWidth / 2
        
        // Итоговая ширина = точки + промежутки + дополнительное_место_для_активной_точки
        let totalWidth = dotsWidth + spacesWidth + activePointExtraWidth + leftOffset
        
        // Высота равна высоте точки
        return CGSize(width: totalWidth, height: dotSize)
    }
    
    // MARK: - Drawing
    
    // Основной метод отрисовки - вызывается системой когда нужно перерисовать view
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Очищаем фон - заливаем всю область прозрачным цветом
        // Это убирает черный прямоугольник который был раньше
        UIColor.clear.setFill()
        UIRectFill(rect)
        
        // Добавляем отступ чтобы первая точка не обрезалась
        let leftPadding: CGFloat = 4
        
        // ШАГ 1: Рисуем все НЕАКТИВНЫЕ точки (круги)
        // Проходим по всем страницам от 0 до (numberOfPages - 1)
        for i in 0..<numberOfPages {
            // Если это НЕ текущая активная страница - рисуем круглую точку
            if i != currentPage {
                // Создаем прямоугольник для точки:
                // x: рассчитываем позицию по горизонтали
                // y: 0 (вверху)
                // width и height: размер точки (квадрат, который станет кругом)
                let dotRect = CGRect(
                    x: getXPosition(for: i) + leftPadding,  // ← добавляем отступ,
                    y: 0,
                    width: dotSize,
                    height: dotSize
                )
                
                // Создаем путь (path) в форме круга/овала
                let dotPath = UIBezierPath(ovalIn: dotRect)
                
                // Устанавливаем серый цвет для неактивной точки
                UIColor.systemGray.setFill()
                
                // Заливаем путь цветом
                dotPath.fill()
            }
        }
        
        // ШАГ 2: Рисуем АКТИВНУЮ точку (прямоугольник с закругленными краями)
        // Проверяем что currentPage в допустимых пределах
        if currentPage < numberOfPages {
            // Создаем прямоугольник для активной точки:
            // x: позиция как у обычной точки, но ширина больше
            // y: 0 (такая же высота как у остальных)
            // width: специальная ширина для активной точки
            // height: такой же как у обычных точек
            let activeRect = CGRect(
                x: getXPosition(for: currentPage) + leftPadding,  // ← добавляем отступ,
                y: 0,
                width: activeDotWidth,
                height: dotSize
            )
            
            // Создаем путь в форме прямоугольника с закругленными краями
            // cornerRadius = половина высоты = получаем скругленные края
            let activePath = UIBezierPath(roundedRect: activeRect, cornerRadius: dotSize/2)
            
            // Устанавливаем розовый цвет для активной точки
            UIColor.systemPink.setFill()
            
            // Заливаем путь цветом
            activePath.fill()
        }
    }
    
    // MARK: - Helper Methods
    
    // Вспомогательный метод для расчета X-позиции точки по ее индексу
    private func getXPosition(for index: Int) -> CGFloat {
        // Каждая следующая точка смещается на:
        // (размер_точки + расстояние_между_точками)
        let basePosition = CGFloat(index) * (dotSize + dotSpacing)
        
        // Всегда центрируем относительно базовой позиции
        let currentWidth = (index == currentPage) ? activeDotWidth : dotSize
        let centeredPosition = basePosition - (currentWidth - dotSize) / 2
        // Не позволяем позиции уходить в отрицательные значения
        return centeredPosition
    }
}
