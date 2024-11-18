import 'package:echo/core/dependecy_injection.dart';
import 'package:echo/core/routing/navigation_service.dart';
import 'package:echo/core/utils/extensions.dart';
import 'package:echo/core/utils/helper_widgets.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:flutter/material.dart';

class ArticleTile extends StatelessWidget {
  final ArticleEntity article;
  const ArticleTile({super.key, required this.article});

  static Widget loading(BuildContext context) {
    return Row(
      children: [
        shimmerWidget(height: context.screenHeight * .12, width: context.screenWidth * .25, radius: 8),
        addHorizontalSpace(context.screenWidth * .02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerWidget(height: 16, width: context.screenWidth * .3, radius: 2),
              addVerticalSpace(context.screenHeight * .02),
              shimmerWidget(height: 16, width: context.screenWidth * .5, radius: 2),
            ],
          ),
        ),
      ],
    );
  }

  static Widget error(BuildContext context) {
    return Row(
      children: [
        Container(
          height: context.screenHeight * .12,
          width: context.screenWidth * .25,
          decoration: BoxDecoration(
            color: Colors.grey[300]!,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        addHorizontalSpace(context.screenWidth * .02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: context.screenWidth * .3,
                decoration: BoxDecoration(
                  color: Colors.grey[300]!,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              addVerticalSpace(context.screenHeight * .02),
              Container(
                height: 16,
                width: context.screenWidth * .5,
                decoration: BoxDecoration(
                  color: Colors.grey[300]!,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sl<NavigationService>().routeTo(route: '/article', arguments: article);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: context.screenHeight * .005),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            
            // article image

            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                article.imageUrl,
                height: context.screenHeight * .12,
                width: context.screenWidth * .25,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: context.screenHeight * .12,
                    width: context.screenWidth * .25,
                    color: Colors.grey[300],
                  );
                },
              ),
            ),
            addHorizontalSpace(context.screenWidth * .02),

            // article details

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // article source

                  Text(
                    article.source.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  addVerticalSpace(context.screenHeight * .01),

                  // article title

                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  addVerticalSpace(context.screenHeight * .01),

                  // aticle publish date
                  Text(
                    article.publishedAt.formattedDate,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(color: context.theme.colorScheme.tertiary),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
