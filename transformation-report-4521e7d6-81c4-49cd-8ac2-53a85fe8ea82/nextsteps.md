# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The solution has no build errors following the transformation. The migration to cross-platform .NET appears to have completed successfully. The following steps outline how to validate, test, and deploy the project.

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are correctly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages that may need to be updated.

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or later and that the `Microsoft.AspNetCore` dependencies are aligned with that version.

## 4. Check for Removed or Changed APIs

Cross-platform .NET removed several APIs that were available in .NET Framework. Verify the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any remain, they must be replaced with ASP.NET Core equivalents.
- **`HttpContext`**: Ensure usage has been migrated to the ASP.NET Core `HttpContext`.
- **`Session` and `Cache`**: Confirm these have been replaced with `ISession` and `IMemoryCache` respectively.
- **`Web.config`**: Configuration should now reside in `appsettings.json` and be accessed via `IConfiguration`.

## 5. Run Existing Tests

If the solution contains a test project, execute the tests to verify runtime behavior:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between .NET Framework and cross-platform .NET rather than simple compilation issues.

## 6. Validate Database Connectivity

If the project uses Entity Framework or direct database access, confirm the following:

- The connection string in `appsettings.json` is correct and accessible from the new environment.
- The Entity Framework version in use is compatible with the target framework (Entity Framework Core is required for cross-platform .NET).
- Run any pending migrations if applicable:

```bash
dotnet ef database update
```

## 7. Test the Application Locally

Run the application locally and manually exercise its primary functionality:

```bash
dotnet run --configuration Release
```

Pay particular attention to:

- Authentication and authorization flows
- Any file system access, ensuring paths are constructed using `Path.Combine` for cross-platform compatibility
- Email or external service integrations that may rely on Windows-specific libraries

## 8. Review Middleware and Startup Configuration

If this is an ASP.NET Core web application, review the `Program.cs` or `Startup.cs` file to confirm:

- Middleware is registered in the correct order
- Services such as MVC, Razor Pages, or Web API are properly configured
- Static file serving is configured if the project serves frontend assets

## 9. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files, assets, and configuration files are present before deploying to the target environment.