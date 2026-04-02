# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully. There are no build errors present in the solution. The following steps outline how to validate, test, and deploy the migrated project.

## 1. Restore Dependencies

Run the following command in the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or packages that could not be resolved. If any packages are missing or incompatible, check the `.csproj` file and update package references to versions that support the target .NET framework.

## 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

## 3. Review Removed or Changed APIs

Since this is a legacy project migrated to cross-platform .NET, manually review the following areas for potential runtime issues that do not surface as build errors:

- **`System.Web` dependencies**: Any code that previously relied on `System.Web` (e.g., `HttpContext`, `HttpRequest`) should now be using `Microsoft.AspNetCore.Http` equivalents.
- **`Global.asax`**: If the original project used `Global.asax`, confirm that its logic has been moved to `Program.cs` or `Startup.cs`.
- **Configuration**: Verify that `Web.config` settings have been migrated to `appsettings.json` and are being read correctly via `IConfiguration`.
- **Session and Authentication**: Confirm that any session or authentication middleware is properly configured in the request pipeline.

## 4. Run the Application Locally

Start the application locally and navigate through its primary functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

- Confirm that all routes resolve correctly.
- Check that database connections are established if the project uses a data layer.
- Review application logs for any runtime exceptions or unhandled errors.

## 5. Execute Unit Tests

If the solution contains test projects, run them to validate core logic:

```bash
dotnet test
```

Review any failing tests. Failures may indicate behavioral differences introduced by the migration rather than build-time issues.

## 6. Validate Static Assets and Views

If the project is a web application, verify the following:

- Static files (CSS, JavaScript, images) are being served correctly. In ASP.NET Core, static files must reside in the `wwwroot` folder and the `UseStaticFiles()` middleware must be registered.
- Razor views or pages render without errors.
- Any Bundling and Minification that was previously handled by `BundleConfig.cs` has been replaced with an appropriate alternative, such as LibMan or a front-end build tool.

## 7. Database and Entity Framework Validation

If the project uses Entity Framework, confirm the following:

- The correct EF Core provider package is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer`).
- Run any pending migrations or verify the schema against the existing database:

```bash
dotnet ef database update
```

- Test all data access paths (queries, inserts, updates, deletes) through the application.

## 8. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element targets the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If a newer LTS version of .NET is available and desired, update this value, re-run `dotnet restore`, and rebuild.

## 9. Publish the Application

Once validation is complete, publish the application to a local folder to confirm the output is correct before deploying to a target environment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files, assemblies, and assets are present.