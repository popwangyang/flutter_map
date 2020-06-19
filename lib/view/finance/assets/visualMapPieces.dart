const visualMapPieces = r'''
            [{
              gt: 80,
              label: '> 80 单位: %'
            },
              {
                gt: 60,
                lte: 80,
                label: '60~80'
              },
              {
                gt: 45,
                lte: 60,
                label: '45~60'
              },
              {
                gt: 30,
                lte: 45,
                label: '30~45'
              },
              {
                gt: 15,
                lte: 30,
                label: '15~30'
              },
              {
                gte: 0,
                lte: 15,
                label: '0~15'
              }]
          ''';