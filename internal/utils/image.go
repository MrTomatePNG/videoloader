package utils

import (
	"bytes"
	"fmt"
	"image"
	"image/color"
	"image/draw"
	_ "image/gif"
	"image/jpeg"
	_ "image/jpeg"
	_ "image/png"
	"os"

	"github.com/nfnt/resize"
)

const (
	TargetWidth  = 800
	TargetHeight = 1200
	JPEGQuality  = 70
)

func ResizeImage(b []byte) (image.Image, error) {
	img, _, err := image.Decode(bytes.NewReader(b))
	if err != nil {
		return nil, fmt.Errorf("error decoding image: %w", err)
	}

	resizedImg := resize.Resize(uint(TargetWidth), 0, img, resize.Lanczos3)
	return resizedImg, nil
}

func CreateCanvasWithImage(resizedImg image.Image) *image.RGBA {
	newHeight := int(float64(TargetWidth) * float64(resizedImg.Bounds().Dy()) / float64(resizedImg.Bounds().Dx()))
	newImg := image.NewRGBA(image.Rect(0, 0, TargetWidth, TargetHeight))

	// Preencher com preto
	for y := range TargetHeight {
		for x := range TargetWidth {
			newImg.Set(x, y, color.Black)
		}
	}

	// Centralizar imagem
	offSetY := (TargetHeight - newHeight) / 2
	draw.Draw(newImg, image.Rect(0, offSetY, TargetWidth, offSetY+newHeight), resizedImg, image.Pt(0, 0), draw.Over)

	return newImg
}

func EncodeJPEG(filePath string, img *image.RGBA) error {
	outFile, err := os.Create(filePath)
	if err != nil {
		return fmt.Errorf("error creating file: %w", err)
	}
	defer outFile.Close()

	opts := &jpeg.Options{Quality: JPEGQuality}
	return jpeg.Encode(outFile, img, opts)
}
