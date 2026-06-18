# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution to cross-platform .NET appears to have completed successfully. No build errors were detected in any of the projects within the solution.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

### 2. Build the Solution
Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

### 3. Run Unit Tests
If the solution contains any test projects, execute them to verify existing functionality has not been broken during the transformation:

```bash
dotnet test --configuration Release --verbosity normal
```

### 4. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 5. Review Removed or Changed APIs
Cross-platform .NET removes or changes certain APIs that were available in .NET Framework. Manually review the following areas of the `GadgetsOnline` project:

- **`System.Web` dependencies**: Any usage of `HttpContext`, `HttpRequest`, or other `System.Web` types should have been replaced with their `Microsoft.AspNetCore` equivalents.
- **`Web.config`**: Configuration should now reside in `appsettings.json`. Confirm that all connection strings, app settings, and other configuration values have been migrated correctly.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been updated to Entity Framework Core and that migrations are functioning as expected.
- **Session and Authentication**: Verify that session management and any authentication/authorization middleware is correctly configured in `Program.cs` or `Startup.cs`.

### 6. Run the Application Locally
Start the application locally and navigate through its core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Check the following at runtime:
- Application starts without exceptions.
- Database connections are established successfully.
- Core user-facing pages and features load and function as expected.
- Any file system paths used in the application are compatible with the operating system you are running on, as path separators differ between Windows and Linux/macOS.

### 7. Check Logging Output
Review the application's runtime logs for any warnings or errors that do not surface at build time, such as missing configuration values or failed service registrations.

### 8. Publish the Application
Once local validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required static assets, configuration files, and binaries are present before deploying to your target environment.